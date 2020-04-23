//
//  TOCollectionViewCell.h
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *colorView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *widthConstraint;

@end

NS_ASSUME_NONNULL_END
