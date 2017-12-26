//
//  CLViewController.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/11/28.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLViewController.h"
#import "CLCollectionViewCell.h"
#import "CLCollectionHeaderView.h"
#import "CLCustomFlowLayout.h"
#import "CLCategoryImage.h"

static NSString *const kImageCellIdentifier = @"CLCollectionViewCell";
static NSString *const kCollectionHeaderViewIdentifier = @"CLCollectionHeaderView";

@interface CLViewController () <UICollectionViewDelegateFlowLayout, CLCollectionHeaderViewDelegate>

@property (nonatomic, strong) NSArray<CLCategoryImage *> *imgs;

@end

@implementation CLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupModel];
    
    CLCustomFlowLayout *flowLayout = [[CLCustomFlowLayout alloc] init];
    flowLayout.sectionColor = [UIColor greenColor];
    self.collectionView.collectionViewLayout = flowLayout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.imgs count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CLCategoryImage *categoryImage = self.imgs[section];
    BOOL hasFolded = categoryImage.hasFolded;
    if (hasFolded) {
        return 0;
    } else {
        return [categoryImage.images count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCellIdentifier forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CLCategoryImage *category = self.imgs[section];
    UIImage *img = category.images[row];
    [cell configWithImg:img];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    CLCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionHeaderViewIdentifier forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    CLCategoryImage *category = self.imgs[section];
    [headerView configWithCategory:category.category];
    headerView.tag = indexPath.section;
    headerView.delegate = self;
    return headerView;
}

#pragma mark -

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    CLCategoryImage *categoryImage = self.imgs[section];
    BOOL hasFolded = categoryImage.hasFolded;
    if (hasFolded) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(30, 50, 30, 50);
}

- (UIColor *)collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout*)collectionViewLayout
     colorForSectionAtIndex:(NSInteger)section {
    if (section % 2 == 0) {
        return [UIColor redColor];
    } else {
        return [UIColor purpleColor];
    }
}


#pragma mark - CLCollectionHeaderViewDelegate

- (void)headerViewDidTouched:(CLCollectionHeaderView *)headerView {
    NSInteger section = headerView.tag;
    CLCategoryImage *category = self.imgs[section];
    
    [self.collectionView performBatchUpdates:^{
        category.hasFolded = !category.hasFolded;
        
        NSArray <UIImage *> *imgs = category.images;
        NSMutableArray *indexPaths = @[].mutableCopy;
        for (NSInteger index = 0; index < imgs.count; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            [indexPaths addObject:indexPath];
        }
        if (category.hasFolded) {
            [self.collectionView deleteItemsAtIndexPaths:indexPaths];
        } else {
            [self.collectionView insertItemsAtIndexPaths:indexPaths];
        }
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - private methods

- (void)setupModel {
    
    NSMutableArray<CLCategoryImage *> *temp = [NSMutableArray arrayWithCapacity:4];
    
    NSMutableArray<UIImage *> *temp1 = @[].mutableCopy;
    for (NSInteger i = 1; i <= 6; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp1 addObject:img];
    }
    CLCategoryImage *category1 = [[CLCategoryImage alloc] initWithImages:temp1 category:@"flickr_1_group"];
    [temp addObject:category1];
    
    NSMutableArray<UIImage *> *temp2 = @[].mutableCopy;
    for (NSInteger i = 7; i <= 12; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp2 addObject:img];
    }
    CLCategoryImage *category2 = [[CLCategoryImage alloc] initWithImages:temp2 category:@"flickr_2_group"];
    [temp addObject:category2];
    
    NSMutableArray<UIImage *> *temp3 = @[].mutableCopy;
    for (NSInteger i = 13; i <= 18; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp3 addObject:img];
    }
    CLCategoryImage *category3 = [[CLCategoryImage alloc] initWithImages:temp3 category:@"flickr_3_group"];
    [temp addObject:category3];
    
    NSMutableArray<UIImage *> *temp4 = @[].mutableCopy;
    for (NSInteger i = 19; i <= 24; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp4 addObject:img];
    }
    CLCategoryImage *category4 = [[CLCategoryImage alloc] initWithImages:temp4 category:@"flickr_4_group"];
    [temp addObject:category4];
    
    self.imgs = temp.copy;
}

@end
