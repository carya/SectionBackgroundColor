//
//  CLCollectionViewFlowLayout.h
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/11/28.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

- (UIColor *)collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     colorForSectionAtIndex:(NSInteger)section;

@end

@protocol CLCollectionViewFlowLayoutUpdateHooks <NSObject>

- (void)configInitialLayoutAttributesForAppearingDecoration:(UICollectionViewLayoutAttributes *)layoutAttributes;

@end

@interface CLCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) UIColor *sectionColor;

@end
