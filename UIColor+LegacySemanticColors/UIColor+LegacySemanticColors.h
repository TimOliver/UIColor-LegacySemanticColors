//
//  UIColor+LegacySemanticColors.h
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LegacySemanticColors)

/** On iOS 12, set whether the colors return their light or dark variants */
+ (void)setLegacyInterfaceStyle:(UIUserInterfaceStyle)style;

/** On iOS 12, set whether the colors return their light or dark variants */
+ (UIUserInterfaceStyle)legacyInterfaceStyle;

/**
* The numbered variations, systemGray2 through systemGray6, are grays which increasingly
* step away from systemGray towards systemBackgroundColor.
*
* In light styles: systemGray1 is slightly lighter than systemGray. systemGray2 is lighter than that, etc.
* In dark styles: systemGray1 is slightly darker than systemGray. systemGray2 is darker than that, etc.
*/
@property (class, nonatomic, readonly) UIColor *systemGray2Color;
@property (class, nonatomic, readonly) UIColor *systemGray3Color;
@property (class, nonatomic, readonly) UIColor *systemGray4Color;
@property (class, nonatomic, readonly) UIColor *systemGray5Color;
@property (class, nonatomic, readonly) UIColor *systemGray6Color;

#pragma mark Foreground colors

/** Foreground colors for static text and related elements. */
@property (class, nonatomic, readonly) UIColor *labelColor;
@property (class, nonatomic, readonly) UIColor *secondaryLabelColor;
@property (class, nonatomic, readonly) UIColor *tertiaryLabelColor;
@property (class, nonatomic, readonly) UIColor *quaternaryLabelColor;

/** Foreground color for standard system links. */
@property (class, nonatomic, readonly) UIColor *linkColor;

/** Foreground color for placeholder text in controls or text fields or text views. */
@property (class, nonatomic, readonly) UIColor *placeholderTextColor;

/**
* Foreground colors for separators (thin border or divider lines).
* `separatorColor` may be partially transparent, so it can go on top of any content.
* `opaqueSeparatorColor` is intended to look similar, but is guaranteed to be opaque, so it will
* completely cover anything behind it.
*/
@property (class, nonatomic, readonly) UIColor *separatorColor;
@property (class, nonatomic, readonly) UIColor *opaqueSeparatorColor;

#pragma mark Background Colors

/**
* Apple has provided two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
*
* Each stack has three "levels" of background colors. The first color is intended to be the
* main background, farthest back. Secondary and tertiary colors are layered on top
* of the main background, when appropriate.
*
* Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
* Apple does not recommend mixing and matching background colors between stacks.
* The foreground colors above are designed to work in both stacks.
*
* 1. systemBackground
*    Use this stack for views with standard table views, and designs which have a white
*    primary background in light mode.
*/
@property (class, nonatomic, readonly) UIColor *systemBackgroundColor;
@property (class, nonatomic, readonly) UIColor *secondarySystemBackgroundColor;
@property (class, nonatomic, readonly) UIColor *tertiarySystemBackgroundColor;

/* 2. systemGroupedBackground
 *    Use this stack for views with grouped content, such as grouped tables and
 *    platter-based designs. These are like grouped table views, but you may use these
 *    colors in places where a table view wouldn't make sense.
 */
@property (class, nonatomic, readonly) UIColor *systemGroupedBackgroundColor;
@property (class, nonatomic, readonly) UIColor *secondarySystemGroupedBackgroundColor;
@property (class, nonatomic, readonly) UIColor *tertiarySystemGroupedBackgroundColor;

#pragma mark Fill Colors

/**
 * Fill colors for UI elements.
 * These are meant to be used over the background colors, since their alpha component is less than 1.
 *
 * systemFillColor is appropriate for filling thin and small shapes.
 * Example: The track of a slider.
 */
@property (class, nonatomic, readonly) UIColor *systemFillColor;

/**
 * secondarySystemFillColor is appropriate for filling medium-size shapes.
 * Example: The background of a switch.
 */
@property (class, nonatomic, readonly) UIColor *secondarySystemFillColor;

/**
 * tertiarySystemFillColor is appropriate for filling large shapes.
 * Examples: Input fields, search bars, buttons.
 */
@property (class, nonatomic, readonly) UIColor *tertiarySystemFillColor;

/**
 * quaternarySystemFillColor is appropriate for filling large areas containing complex content.
 * Example: Expanded table cells.
 */
@property (class, nonatomic, readonly) UIColor *quaternarySystemFillColor;

@end

NS_ASSUME_NONNULL_END
