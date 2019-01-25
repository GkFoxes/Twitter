//
//  LoginViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginTapeed:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // test [self showAlertMessageWithTitle:@"Warning!" message:@"Some bla-bla"];
}

- (void)viewDidAppear:(BOOL)animated {
    [_usernameTextField becomeFirstResponder];
}

// Choose next TextField or Login, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _usernameTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [self loginTapeed:self];
    }
    
    return YES;
}

// Warning alert message
- (void) showAlertMessageWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// MARK: - Login Button Action
- (IBAction)loginTapeed:(id)sender {
    printf("Login working!\n");
    
    UIStoryboard *feedStoryboard = [UIStoryboard storyboardWithName:@"Feed" bundle:nil];
    
    UIViewController *sideMenu = [feedStoryboard instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
    UIViewController *feedView = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:feedView leftDrawerViewController:sideMenu rightDrawerViewController:nil];
    
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.window.rootViewController = self.drawerController;
    
    [self performSegueWithIdentifier:@"feedFromLoginSegue" sender:sender];
}

@end
