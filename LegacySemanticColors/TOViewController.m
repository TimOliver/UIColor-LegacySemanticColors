//
//  ViewController.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "TOViewController.h"
#import "TOCollectionViewCell.h"

@interface UIColor (LegacySemanticColor)

+ (UIColor *)systemBackgroundColor;

@end


@interface TOViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;

@end

@implementation TOViewController

- (instancetype)init
{
    if (self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Semantic Colors";
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
    
    self.collectionView.backgroundColor = [UIColor systemBackgroundColor];
    self.collectionView.alwaysBounceVertical = YES;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    }
    
    // Configure collection view with our nib
    UINib *nib = [UINib nibWithNibName:@"TOCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"TOCollectionViewCell"];

    self.flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.flowLayout.minimumInteritemSpacing = 20.0f;
    self.flowLayout.minimumLineSpacing = 20.0f;
    [self updateCollectionViewInset];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateCollectionViewInset];
}

- (void)updateCollectionViewInset
{
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        self.flowLayout.sectionInset = (UIEdgeInsets){30, 30, 30, 30};
    }
    else {
        self.flowLayout.sectionInset = (UIEdgeInsets){10, 10, 10, 10};
    }
}

#pragma mark - Data Source -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Delegate -

#pragma mark - Accessors -

- (UICollectionViewFlowLayout *)flowLayout
{
    return (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
}

@end
