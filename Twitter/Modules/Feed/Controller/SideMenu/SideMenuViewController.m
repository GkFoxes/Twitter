//
//  SideMenuViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

- (IBAction)exitTapped:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *databaseRef;
@property (strong, nonatomic) FIRUser *user;

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseRef = [[FIRDatabase database] reference];
    self.user = [FIRAuth auth].currentUser;
    
    [[[self.databaseRef child:@"user_profiles"] child:self.user.uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.nameLabel.text = snapshot.value[@"name"];
        NSString *handleStr = @"@";
        handleStr = [handleStr stringByAppendingString:snapshot.value[@"handle"]];
        self.usernameLabel.text = handleStr;
        self.aboutLabel.text = snapshot.value[@"about"];
    }];
}

- (IBAction)exitTapped:(id)sender {
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    } else {
        //Delete Slide Menu from stack
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *initialLoginViewController = [loginStoryboard instantiateViewControllerWithIdentifier:@"initialLoginView"];
        UIWindow *window = (UIWindow *)[[UIApplication sharedApplication].windows firstObject];
        window.rootViewController = initialLoginViewController;
        
        [self performSegueWithIdentifier:@"unwindToLogin" sender:sender];
    }
}
@end
