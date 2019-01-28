//
//  RegisterViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)nextTapeed:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *databaseRef;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseRef = [[FIRDatabase database] reference];
}

- (void)viewDidAppear:(BOOL)animated {
    [_emailTextField becomeFirstResponder];
}

// Choose next TextField or Register, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _emailTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [self nextTapeed:self];
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

// MARK: - Register Button Action
- (IBAction)nextTapeed:(id)sender {
    
    if (_emailTextField.text.length > 0 && _passwordTextField.text.length >= 6) {
        
        [[FIRAuth auth] createUserWithEmail:_emailTextField.text password:_passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        
            if (error != nil) {
                [self showAlertMessageWithTitle:@"Warning" message:@"Check your Email, please."];
            } else {
                [[FIRAuth auth] signInWithEmail:self->_emailTextField.text password:self->_passwordTextField.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                    
                    if (error != nil) {
                        [self showAlertMessageWithTitle:@"Warning" message:@"Try again later, please."];
                    } else {
                        [[[self.databaseRef child:@"user_profiles"] child:authResult.user.uid] setValue:@{@"email": self->_emailTextField.text}];
                            
                        [self performSegueWithIdentifier:@"nextFromRegisterSegue" sender:sender];
                    }
                }];
            }
        }];
    } else {
        [self showAlertMessageWithTitle:@"Empty field" message:@"You did not fill all the fields or your password is small, please check again."];
    }
}

@end
