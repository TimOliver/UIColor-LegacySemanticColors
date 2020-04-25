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
    
    // Set up segmented control
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Light", @"Dark"]];
    if (self.view.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
        segmentedControl.selectedSegmentIndex = 1;
    }
    else {
        segmentedControl.selectedSegmentIndex = 0;
    }
    [segmentedControl addTarget:self
                         action:@selector(segmentedControlChanged:)
               forControlEvents:UIControlEventValueChanged];
    [segmentedControl sizeToFit];
    self.navigationItem.titleView = segmentedControl;
    
    if (@available(iOS 13.0, *)) {
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        separatorView.backgroundColor = [UIColor separatorColor];
        separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.collectionView addSubview:separatorView];
        
        CGRect frame = CGRectZero;
        frame.size.height = 1.0f / UIScreen.mainScreen.nativeScale;
        frame.origin.x = 20.0f;
        frame.origin.y = 0;
        frame.size.width = self.view.frame.size.width - 40.0f;
        separatorView.frame = frame;
    }
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

#pragma mark - Theme Swapping -

- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl
{
    UIUserInterfaceStyle style = UIUserInterfaceStyleLight;
    if (segmentedControl.selectedSegmentIndex == 1) {
        style = UIUserInterfaceStyleDark;
    }
    
    // Set override theme on iOS 13
    if (@available(iOS 13.0, *)) {
        self.navigationController.overrideUserInterfaceStyle = style;
        return;
    }
    
    // Perform manual view update on iOS 12
    [UIColor setLegacyInterfaceStyle:style];
    
    UIBarStyle barStyle = UIBarStyleDefault;
    if (style == UIUserInterfaceStyleDark) {
        barStyle = UIBarStyleBlack;
    }
    self.navigationController.navigationBar.barStyle = barStyle;
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor systemBackgroundColor];
    
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    if (style == UIUserInterfaceStyleDark) {
        self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    }
    
    self.navigationController.view.tintColor = [UIColor systemBlueColor];
}

#pragma mark - Data Source -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.colorsList[@"Colors"] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *colors = self.colorsList[@"Colors"];
    return [colors[section] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOCollectionViewCell"
                                                                           forIndexPath:indexPath];
    
    NSArray *colors = self.colorsList[@"Colors"][indexPath.section];
    NSString *colorName = colors[indexPath.row];
    
    colorName = [colorName stringByAppendingString:@"Color"];
    cell.colorView.backgroundColor = [UIColor performSelector:NSSelectorFromString(colorName)];
    cell.textLabel.text = colorName;
    cell.textLabel.textColor = [UIColor labelColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    TOCollectionHeaderView *headerView = (TOCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                      withReuseIdentifier:@"TOCollectionHeaderView"
                                                                                                             forIndexPath:indexPath];
    headerView.titleLabel.text = self.colorsList[@"SectionNames"][indexPath.section];
    headerView.titleLabel.textColor = [UIColor labelColor];
    [headerView setNeedsLayout];
    return headerView;
}

#pragma mark - Delegate -

#pragma mark - Accessors -

- (UICollectionViewFlowLayout *)flowLayout
{
    return (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
}

@end
