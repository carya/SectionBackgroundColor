//
//  CLViewController.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/11/28.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLViewController.h"
#import "CLCollectionViewCell.h"
#import "CLCollectionViewFlowLayout.h"

static NSString *const kImageCellIdentifier = @"CLCollectionViewCell";
@interface CLViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray<NSArray<UIImage *> *> *imgs;

@end

@implementation CLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupModel];
    
    CLCollectionViewFlowLayout *flowLayout = [[CLCollectionViewFlowLayout alloc] init];
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
    return [self.imgs[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageCellIdentifier forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UIImage *img = self.imgs[section][row];
    [cell configWithImg:img];
    return cell;
}

#pragma mark -

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section % 2 == 0) {
        return UIEdgeInsetsMake(30, 50, 30, 50);
    } else {
        return UIEdgeInsetsMake(0, 50, 0, 50);
    }
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

#pragma mark - private methods

- (void)setupModel {
    
    NSMutableArray<NSMutableArray<UIImage *> *> *temp = [NSMutableArray arrayWithCapacity:4];
    
    NSMutableArray<UIImage *> *temp1 = @[].mutableCopy;
    for (NSInteger i = 1; i <= 6; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp1 addObject:img];
    }
    [temp addObject:temp1];
    
    NSMutableArray<UIImage *> *temp2 = @[].mutableCopy;
    for (NSInteger i = 7; i <= 12; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp2 addObject:img];
    }
    [temp addObject:temp2];
    
    NSMutableArray<UIImage *> *temp3 = @[].mutableCopy;
    for (NSInteger i = 13; i <= 18; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp3 addObject:img];
    }
    [temp addObject:temp3];
    
    NSMutableArray<UIImage *> *temp4 = @[].mutableCopy;
    for (NSInteger i = 19; i <= 24; i++) {
        NSString *imgurl = [NSString stringWithFormat:@"flickr_%@.jpg", @(i)];
        UIImage *img = [UIImage imageNamed:imgurl];
        [temp4 addObject:img];
    }
    [temp addObject:temp4];
    
    self.imgs = temp.copy;
}

@end
