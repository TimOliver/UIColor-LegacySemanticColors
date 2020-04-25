//
//  TOCollectionViewCell.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "TOCollectionViewCell.h"

@implementation TOCollectionViewCell

- (void)layoutSubviews
{
    CGSize size = self.frame.size;
    
    // Color View frame
    CGRect frame = self.colorView.frame;
    frame.size.width = size.width;
    frame.size.height = size.width;
    self.colorView.frame = frame;
    
    frame = CGRectZero;
    frame.size = [self.textLabel sizeThatFits:size];
    self.textLabel.frame = frame;
    
    self.textLabel.center = (CGPoint){size.width * 0.5f, self.colorView.frame.size.height + 27.0f};
    
    self.colorView.layer.borderColor = [UIColor colorWithWhite:0.5f alpha:0.1f].CGColor;
    self.colorView.layer.borderWidth = 1.0f;
    
    if (@available(iOS 13.0, *)) {
        self.colorView.layer.cornerCurve = kCACornerCurveContinuous;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize collectionViewSize = collectionView.frame.size;
    UIEdgeInsets insets = flowLayout.sectionInset;
    
    // For compact layouts, such as iPhone
    NSInteger numberOfCellsPerRow = 0;
    if (collectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact)
    {
        numberOfCellsPerRow = 2;
        if (collectionViewSize.width > collectionViewSize.height) {
            numberOfCellsPerRow = 4;
        }
    }
    else {
        // For regular layouts including iPad and iPhone 6 Plus
        numberOfCellsPerRow = 5;
        if (collectionViewSize.width > collectionViewSize.height) {
            numberOfCellsPerRow = 6;
        }
    }
    
    CGFloat padding = insets.left + insets.right;
    padding += (flowLayout.minimumInteritemSpacing * (numberOfCellsPerRow - 1));
    size.width = floorf((collectionViewSize.width - padding) / numberOfCellsPerRow);
    size.height = size.width + 54.0f;
    return size;
}

@end
