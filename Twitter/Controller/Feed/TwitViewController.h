//
//  TwitViewController.h
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TwitViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *text;

@end

NS_ASSUME_NONNULL_END
