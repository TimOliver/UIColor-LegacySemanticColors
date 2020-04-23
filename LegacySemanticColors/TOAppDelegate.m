//
//  AppDelegate.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "TOAppDelegate.h"
#import "TOViewController.h"

@interface TOAppDelegate ()

@end

@implementation TOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TOViewController *viewController = [[TOViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
