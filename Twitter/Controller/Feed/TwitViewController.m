//
//  TwitViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "TwitViewController.h"

@interface TwitViewController ()

@end

@implementation TwitViewController

@synthesize nameLabel;
@synthesize usernameLabel;
@synthesize textLabel;

@synthesize name;
@synthesize username;
@synthesize text;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nameLabel.text = name;
    usernameLabel.text = username;
    textLabel.text = text;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Cancel Side Menu swipe
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

@end
