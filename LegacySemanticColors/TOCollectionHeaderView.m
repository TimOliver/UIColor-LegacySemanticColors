//
//  TOCollectionHeaderView.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 24/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "TOCollectionHeaderView.h"

@implementation TOCollectionHeaderView

- (void)layoutSubviews
{
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    UIEdgeInsets insets = flowLayout.sectionInset;
    
    [self.titleLabel sizeToFit];
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = insets.left;
    self.titleLabel.frame = frame;
}

@end
