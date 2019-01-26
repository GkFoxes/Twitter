//
//  FirstViewController.h
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FeedViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;

- (IBAction)showSideMenu:(id)sender;

@end
