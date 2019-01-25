//
//  RegisterViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)registerTapeed:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [_usernameTextField becomeFirstResponder];
}

//Choose next TextField or Register, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _usernameTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [self registerTapeed:self];
    }
    
    return YES;
}

// MARK: - Warning alert message
- (void) showAlertMessageWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// MARK: - Register Button Action
- (IBAction)registerTapeed:(id)sender {
    printf("Register working!\n");
    
    [self performSegueWithIdentifier:@"feedFromRegisterSegue" sender:sender];
}

@end
