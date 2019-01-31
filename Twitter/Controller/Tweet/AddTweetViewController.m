//
//  AddTweetViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 29/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "AddTweetViewController.h"

@interface AddTweetViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (IBAction)tweetTapped:(id)sender;
- (IBAction)bookmarkTapped:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *databaseRef;
@property (strong, nonatomic) FIRUser *user;

@end

@implementation AddTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [FIRAuth auth].currentUser;
    self.databaseRef = [[FIRDatabase database] reference];
    
    _tweetTextView.textColor = UIColor.lightGrayColor;
    _tweetTextView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Cancel Side Menu swipe
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)viewDidAppear:(BOOL)animated {
    [_tweetTextView resignFirstResponder];
}

-(void) textViewDidBeginEditing:(UITextView *)tweetTextView {
    if (_tweetTextView.textColor == UIColor.lightGrayColor) {
        _tweetTextView.textColor = UIColor.blackColor;
        [_tweetTextView setText:@""];
    }
}

// MARK: - Tweet Button Action

- (IBAction)tweetTapped:(id)sender {
    
    if (_tweetTextView.text.length > 0) {
        
        NSString *uid = _user.uid;
        NSString *key = [[self.databaseRef child:@"tweets"] childByAutoId].key;
        NSUInteger currentTime = [[NSDate date] timeIntervalSince1970];
        
        NSString *tweetsUpdates = [NSString stringWithFormat: @"/tweets/%@/%@/text",uid,key];
        NSString *tweetTextUpdates = [NSString stringWithFormat: @"%@", _tweetTextView.text];
        NSString *tweetTimeUpdates = [NSString stringWithFormat: @"/tweets/%@/%@/timestamp",uid,key];
        NSString *timeUpdates = [NSString stringWithFormat: @"%lu",(unsigned long)currentTime];

        NSDictionary *childUpdates = @{tweetsUpdates: tweetTextUpdates,
                               tweetTimeUpdates: timeUpdates};
        
        [self.databaseRef updateChildValues:childUpdates];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)bookmarkTapped:(id)sender {
    if (_tweetTextView.text.length > 0) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Enter the name of bookmark"
                                                                       message:@"This text wiil be save for future tweet."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Name";
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSArray * textfields = alert.textFields;
            UITextField * nameTextField = textfields[0];
            
            //Save in Realm
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            TweetRealm *information = [[TweetRealm alloc] init];
            information.name = nameTextField.text;
            information.text = self.tweetTextView.text;
            [realm addObject:information];
            [realm commitWriteTransaction];
            
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        
         UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
