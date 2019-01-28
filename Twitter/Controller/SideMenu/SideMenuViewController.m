//
//  SideMenuViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

- (IBAction)exitTapped:(id)sender;

@property (strong, nonatomic) FIRUser *user;

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [FIRAuth auth].currentUser;
    _usernameLabel.text = _user.uid;
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
