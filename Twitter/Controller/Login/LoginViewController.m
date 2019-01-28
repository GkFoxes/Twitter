//
//  LoginViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginTapeed:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *databaseRef;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseRef = [[FIRDatabase database] reference];
}

- (void)viewDidAppear:(BOOL)animated {
    [_emailTextField becomeFirstResponder];
}

// Choose next TextField or Login, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _emailTextField) {
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
    
    if (_emailTextField.text.length > 0 && _passwordTextField.text.length >= 6) {
        
        [[FIRAuth auth] signInWithEmail:self->_emailTextField.text password:self->_passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                                 
            if (error == nil) {
                [[[[self.databaseRef child:@"user_profiles"] child:authResult.user.uid] child:@"handle"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    
                    if (snapshot.exists) {
                        
                        //Setting Side Menu
                        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                        [appDelegate settingFeedSideMenu];
                        
                        [self performSegueWithIdentifier:@"feedFromLoginSegue" sender:sender];
                    } else {
                        [self performSegueWithIdentifier:@"registerDetailFromLogin" sender:sender];
                    }
                }];
            } else {
                [self showAlertMessageWithTitle:@"Something Wrong" message:@"Please try again later."];
            }
        }];
    } else {
        [self showAlertMessageWithTitle:@"Empty field" message:@"You did not fill all the fields or your password is small, please check again."];
    }
}

@end
