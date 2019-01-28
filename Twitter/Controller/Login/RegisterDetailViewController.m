//
//  RegisterDetailViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 28/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "RegisterDetailViewController.h"
@import Firebase;

@interface RegisterDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;


@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerTapped:(id)sender;

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [_nameTextField becomeFirstResponder];
}

// Choose next TextField or Register, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _nameTextField) {
        [textField resignFirstResponder];
        [_usernameTextField becomeFirstResponder];
    } else if (textField == _usernameTextField) {
        [self registerTapped:self];
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

- (IBAction)registerTapped:(id)sender {
    
    if (_nameTextField.text.length > 0 && _usernameTextField.text.length > 0) {
        //Setting Side Menu
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate settingFeedSideMenu];
        
        [self performSegueWithIdentifier:@"feedFromRegisterSegue" sender:sender];
    } else {
        [self showAlertMessageWithTitle:@"Empty field" message:@"You did not fill all the fields, please check again."];
    }
}

@end
