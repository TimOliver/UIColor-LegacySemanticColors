//
//  main.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([TOAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
