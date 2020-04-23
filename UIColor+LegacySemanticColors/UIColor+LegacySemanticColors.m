//
//  UIColor+LegacySemanticColors.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "UIColor+LegacySemanticColors.h"
#import <objc/runtime.h>

static UIUserInterfaceStyle _legacyStyle = UIUserInterfaceStyleLight;

// ##########################################################

#define UIColorFromRGB(rgbValue) \
            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 24))/255.0 \
                            green:((float)((rgbValue & 0x00FF00) >> 16))/255.0 \
                             blue:((float)((rgbValue & 0x0000FF) >>  8))/255.0 \
                            alpha:((float)((rgbValue & 0x0000FF) >>  0))/255.0]

// ##########################################################

static inline UIColor *UIColorLegacyColorForStyle(NSUInteger lightColor, NSUInteger darkColor)
{
    if (_legacyStyle == UIUserInterfaceStyleDark) { return UIColorFromRGB(darkColor); }
    return UIColorFromRGB(lightColor);
}

// ##########################################################

@implementation UIColor (LegacySemanticColors)

+ (void)load
{
    // Skip if we're on iOS 13 or above
    if (@available(iOS 13.0, *)) {
        return;
    }
    
    // Integrate the new methods
    [self swizzleColorSelectors];
    [self implementNewColorSelectors];
}

+ (void)swizzleColorSelectors
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(systemRedColor) withNewSelector:@selector(lgcy_systemRedColor)];
        [self swizzleSelector:@selector(systemGreenColor) withNewSelector:@selector(lgcy_systemGreenColor)];
        [self swizzleSelector:@selector(systemBlueColor) withNewSelector:@selector(lgcy_systemBlueColor)];
        [self swizzleSelector:@selector(systemOrangeColor) withNewSelector:@selector(lgcy_systemOrangeColor)];
        [self swizzleSelector:@selector(systemYellowColor) withNewSelector:@selector(lgcy_systemYellowColor)];
        [self swizzleSelector:@selector(systemPinkColor) withNewSelector:@selector(lgcy_systemPinkColor)];
        [self swizzleSelector:@selector(systemPurpleColor) withNewSelector:@selector(lgcy_systemPurpleColor)];
        [self swizzleSelector:@selector(systemTealColor) withNewSelector:@selector(lgcy_systemTealColor)];
        [self swizzleSelector:@selector(systemIndigoColor) withNewSelector:@selector(lgcy_systemIndigoColor)];
        [self swizzleSelector:@selector(systemGrayColor) withNewSelector:@selector(lgcy_systemGrayColor)];
    });
}

+ (void)implementNewColorSelectors
{
    
}

#pragma mark - Swizzled Methods -

+ (UIColor *)lgcy_systemRedColor { return UIColorLegacyColorForStyle(0xff3b30ff, 0xff453aff); }
+ (UIColor *)lgcy_systemGreenColor { return UIColorLegacyColorForStyle(0x34c759ff, 0x30d158ff); }
+ (UIColor *)lgcy_systemBlueColor { return UIColorLegacyColorForStyle(0x007affff, 0x0a84ffff); }
+ (UIColor *)lgcy_systemOrangeColor { return UIColorLegacyColorForStyle(0xff9500ff, 0xff9f0aff); }
+ (UIColor *)lgcy_systemYellowColor { return UIColorLegacyColorForStyle(0xffcc00ff, 0xffd60aff); }
+ (UIColor *)lgcy_systemPinkColor { return UIColorLegacyColorForStyle(0xff2d55ff, 0xff375fff); }
+ (UIColor *)lgcy_systemPurpleColor { return UIColorLegacyColorForStyle(0xaf52deff, 0xbf5af2ff); }
+ (UIColor *)lgcy_systemTealColor { return UIColorLegacyColorForStyle(0x5ac8faff, 0x64d2ffff); }
+ (UIColor *)lgcy_systemIndigoColor { return UIColorLegacyColorForStyle(0x5856d6ff, 0x5e5ce6ff); }
+ (UIColor *)lgcy_systemGrayColor { return UIColorLegacyColorForStyle(0x8e8e93ff, 0x8e8e93ff); }

#pragma mark - Added Methods -

//UIColor *UIColorSystemGray2Color()
//{
//
//}

#pragma mark - External Configuration -

+ (void)setLegacyInterfaceStyle:(UIUserInterfaceStyle)style
{
    _legacyStyle = style;
}

+ (UIUserInterfaceStyle)legacyInterfaceStyle
{
    return _legacyStyle;
}

#pragma mark - Method Swizzling -

// https://nshipster.com/method-swizzling/
+ (void)swizzleSelector:(SEL)originalSelector withNewSelector:(SEL)swizzledSelector
{
    Class class = object_getClass((id)self);

    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
        originalSelector,
        method_getImplementation(swizzledMethod),
        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
            swizzledSelector,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
