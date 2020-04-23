//
//  ViewController.m
//  LegacySemanticColors
//
//  Created by Tim Oliver on 23/4/20.
//  Copyright © 2020 Tim Oliver. All rights reserved.
//

#import "TOViewController.h"
#import "TOCollectionViewCell.h"
#import "TOCollectionHeaderView.h"

#import "UIColor+LegacySemanticColors.h"

@interface UIColor (LegacySemanticColor)

+ (UIColor *)systemBackgroundColor;

@end


@interface TOViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSDictionary *colorsList;

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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Colors" ofType:@"plist"];
    self.colorsList = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
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

    nib = [UINib nibWithNibName:@"TOCollectionHeaderView" bundle:nil];
    [self.collectionView registerNib:nib
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"TOCollectionHeaderView"];
    
    self.flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    self.flowLayout.minimumInteritemSpacing = 20.0f;
    self.flowLayout.minimumLineSpacing = 20.0f;
    self.flowLayout.headerReferenceSize = CGSizeMake(0, 54);
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
        self.flowLayout.sectionInset = (UIEdgeInsets){0, 30, 30, 30};
    }
    else {
        self.flowLayout.sectionInset = (UIEdgeInsets){0, 10, 10, 10};
    }
}

#pragma mark - Data Source -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.colorsList.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *keyName = self.colorsList.allKeys[section];
    return [self.colorsList[keyName] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOCollectionViewCell"
                                                                           forIndexPath:indexPath];
    
    NSString *keyName = self.colorsList.allKeys[indexPath.section];
    NSString *colorName = self.colorsList[keyName][indexPath.row];
    
    colorName = [colorName stringByAppendingString:@"Color"];
    cell.colorView.backgroundColor = [UIColor performSelector:NSSelectorFromString(colorName)];
    cell.textLabel.text = colorName;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    TOCollectionHeaderView *headerView = (TOCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                      withReuseIdentifier:@"TOCollectionHeaderView"
                                                                                                             forIndexPath:indexPath];
    headerView.titleLabel.text = self.colorsList.allKeys[indexPath.section];
    return headerView;
}

#pragma mark - Delegate -

#pragma mark - Accessors -

- (UICollectionViewFlowLayout *)flowLayout
{
    return (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
}

@end
