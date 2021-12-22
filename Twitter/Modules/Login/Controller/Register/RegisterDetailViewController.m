//
//  RegisterDetailViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 28/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "RegisterDetailViewController.h"

@interface RegisterDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *handleTextField;
@property (weak, nonatomic) IBOutlet UITextField *aboutTextField;

- (IBAction)registerTapped:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *databaseRef;
@property (strong, nonatomic) FIRUser *user;

@end

@implementation RegisterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.user = [FIRAuth auth].currentUser;
    self.databaseRef = [[FIRDatabase database] reference];
    
    //Hide cancel button
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [_nameTextField becomeFirstResponder];
}

// Choose next TextField or Register, when click Return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _nameTextField) {
        [textField resignFirstResponder];
        [_handleTextField becomeFirstResponder];
    } else if (textField == _handleTextField) {
        [textField resignFirstResponder];
        [_aboutTextField becomeFirstResponder];
    } else if (textField == _aboutTextField) {
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

// MARK: - Register Detail Button Action

- (IBAction)registerTapped:(id)sender {
    
    if (_nameTextField.text.length > 0 && _handleTextField.text.length > 0 && _aboutTextField.text.length > 0) {
        
        [[[self.databaseRef child:@"handles"] child:_handleTextField.text] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            if (snapshot.exists) {
                [self showAlertMessageWithTitle:@"Username exist" message:@"Username already in use, please try another."];
            } else {
                
                //Update the handle and create in the handles node
                [[[[self.databaseRef child:@"user_profiles"] child:self.user.uid] child: @"handle"] setValue:self.handleTextField.text.lowercaseString];
                
                //Update the name of the user
                [[[[self.databaseRef child:@"user_profiles"] child:self.user.uid] child: @"name"] setValue:self.nameTextField.text];
                
                //Update the about of the user
                [[[[self.databaseRef child:@"user_profiles"] child:self.user.uid] child: @"about"] setValue:self.aboutTextField.text];
                
                //Update the handle
                [[[self.databaseRef child:@"handles"] child:self.handleTextField.text.lowercaseString] setValue:self.user.uid];
                
                
                //Setting Side Menu
                AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
                [appDelegate settingFeedSideMenu];
                
                [self performSegueWithIdentifier:@"feedFromRegisterSegue" sender:sender];
            }
        }];
    } else {
        [self showAlertMessageWithTitle:@"Empty field" message:@"You did not fill all the fields, please check again."];
    }
}

@end
