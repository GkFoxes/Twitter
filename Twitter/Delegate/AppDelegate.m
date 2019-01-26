//
//  AppDelegate.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self opedFeedSideMenu];
    return YES;
}

// MARK: - Side menu
-(void)opedFeedSideMenu {
    UIStoryboard *feedStoryboard = [UIStoryboard storyboardWithName:@"Feed" bundle:nil];

    UIViewController *sideMenu = [feedStoryboard instantiateViewControllerWithIdentifier:@"SideMenuViewController"];
    UITabBarController *feedView = [feedStoryboard instantiateViewControllerWithIdentifier:@"FeedTabBarViewController"];

    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:feedView leftDrawerViewController:sideMenu];

    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;

    _window.rootViewController = self.drawerController;
    [_window makeKeyAndVisible];
}

@end
