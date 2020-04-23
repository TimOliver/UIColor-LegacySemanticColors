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
            [UIColor colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
                            green:((float)((rgbValue & 0x00FF0000) >> 16))/255.0 \
                             blue:((float)((rgbValue & 0x0000FF00) >>  8))/255.0 \
                            alpha:((float)((rgbValue & 0x000000FF) >>  0))/255.0]

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
    const char *args = "@:@";
    Class class = object_getClass((id)self);
    class_addMethod(class, @selector(systemGray2Color), (IMP)UIColorSystemGray2Color, args);
    class_addMethod(class, @selector(systemGray3Color), (IMP)UIColorSystemGray3Color, args);
    class_addMethod(class, @selector(systemGray4Color), (IMP)UIColorSystemGray4Color, args);
    class_addMethod(class, @selector(systemGray5Color), (IMP)UIColorSystemGray5Color, args);
    class_addMethod(class, @selector(systemGray6Color), (IMP)UIColorSystemGray5Color, args);
    
    class_addMethod(class, @selector(labelColor), (IMP)UIColorLabelColor, args);
    class_addMethod(class, @selector(secondaryLabelColor), (IMP)UIColorSecondaryLabelColor, args);
    class_addMethod(class, @selector(tertiaryLabelColor), (IMP)UIColorTertiaryLabelColor, args);
    class_addMethod(class, @selector(quaternaryLabelColor), (IMP)UIColorQuaternaryLabelColor, args);

    class_addMethod(class, @selector(linkColor), (IMP)UIColorLinkColor, args);
    
    class_addMethod(class, @selector(placeholderTextColor), (IMP)UIColorPlaceholderTextColor, args);
    
    class_addMethod(class, @selector(separatorColor), (IMP)UIColorSeparatorColor, args);
    class_addMethod(class, @selector(opaqueSeparatorColor), (IMP)UIColorOpaqueSeparatorColor, args);

    class_addMethod(class, @selector(systemBackgroundColor), (IMP)UIColorSystemBackgroundColor, args);
    class_addMethod(class, @selector(secondarySystemBackgroundColor), (IMP)UIColorSecondarySystemBackgroundColor, args);
    class_addMethod(class, @selector(tertiarySystemBackgroundColor), (IMP)UIColorTertiarySystemBackgroundColor, args);
    
    class_addMethod(class, @selector(systemGroupedBackgroundColor), (IMP)UIColorSystemGroupedBackgroundColor, args);
    class_addMethod(class, @selector(secondarySystemGroupedBackgroundColor), (IMP)UIColorSecondarySystemGroupedBackgroundColor, args);
    class_addMethod(class, @selector(tertiarySystemGroupedBackgroundColor), (IMP)UIColorTertiarySystemGroupedBackgroundColor, args);

    class_addMethod(class, @selector(systemFillColor), (IMP)UIColorSystemFillColor, args);
    class_addMethod(class, @selector(secondarySystemFillColor), (IMP)UIColorSecondarySystemFillColor, args);
    class_addMethod(class, @selector(tertiarySystemFillColor), (IMP)UIColorTertiarySystemFillColor, args);
    class_addMethod(class, @selector(quaternarySystemFillColor), (IMP)UIColorQuaternarySystemFillColor, args);
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

UIColor *UIColorSystemGray2Color(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xaeaeb2ff, 0x636366ff); }
UIColor *UIColorSystemGray3Color(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xc7c7ccff, 0x48484aff); }
UIColor *UIColorSystemGray4Color(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xd1d1d6ff, 0x3a3a3cff); }
UIColor *UIColorSystemGray5Color(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xe5e5eaff, 0x2c2c2eff); }
UIColor *UIColorSystemGray6Color(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xf2f2f7ff, 0x1c1c1eff); }

UIColor *UIColorLabelColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x000000ff, 0xffffffff); }
UIColor *UIColorSecondaryLabelColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x3c3c4399, 0xebebf599); }
UIColor *UIColorTertiaryLabelColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x3c3c434c, 0xebebf54c); }
UIColor *UIColorQuaternaryLabelColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x3c3c432d, 0xebebf52d); }

UIColor *UIColorLinkColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x007affff, 0x0984ffff); }

UIColor *UIColorPlaceholderTextColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x3c3c434c, 0xebebf54c); }

UIColor *UIColorSeparatorColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x3c3c4349, 0x54545899); }
UIColor *UIColorOpaqueSeparatorColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xc6c6c8ff, 0x38383aff); }

UIColor *UIColorSystemBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xffffffff, 0x000000ff); }
UIColor *UIColorSecondarySystemBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xf2f2f7ff, 0x1c1c1eff); }
UIColor *UIColorTertiarySystemBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xffffffff, 0x2c2c2eff); }

UIColor *UIColorSystemGroupedBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xf2f2f7ff, 0x000000ff); }
UIColor *UIColorSecondarySystemGroupedBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xffffffff, 0x1c1c1eff); }
UIColor *UIColorTertiarySystemGroupedBackgroundColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0xf2f2f7ff, 0x2c2c2eff); }

UIColor *UIColorSystemFillColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x78788033, 0x7878805b); }
UIColor *UIColorSecondarySystemFillColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x78788028, 0x78788051); }
UIColor *UIColorTertiarySystemFillColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x7676801e, 0x7676803d); }
UIColor *UIColorQuaternarySystemFillColor(id self, SEL _cmd) { return UIColorLegacyColorForStyle(0x74748014, 0x7676802d); }

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
