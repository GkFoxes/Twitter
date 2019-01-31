//
//  AppDelegate.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) FIRUser *user;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    self.user = [FIRAuth auth].currentUser;
    
    if ([FIRAuth auth].currentUser) {
        [self settingFeedSideMenu];
    }
    
    return YES;
}

// MARK: - Side Menu
-(void)settingFeedSideMenu {
    
    UIStoryboard *feedStoryboard = [UIStoryboard storyboardWithName:@"Feed" bundle:nil];

    UIViewController *sideMenu = [feedStoryboard instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
    UITabBarController *feedView = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedTabBarViewController"];

    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:feedView leftDrawerViewController:sideMenu];

    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;

    _window.rootViewController = self.drawerController;
    [_window makeKeyAndVisible];
}

-(void)cancelSideMenu {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
@end
