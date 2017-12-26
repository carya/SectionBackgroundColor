//
//  CLCustomFlowLayout.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/22.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCustomFlowLayout.h"

static const CGFloat kItemDemension = 140;

@interface CLCustomFlowLayout () <CLCollectionViewFlowLayoutUpdateHooks>

@end

@implementation CLCustomFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kItemDemension, kItemDemension);
        self.sectionInset = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
        self.minimumLineSpacing = 15.0f;
        self.minimumInteritemSpacing = 15.0f;
        self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 44);
    }
    
    return self;
}

- (void)configInitialLayoutAttributesForAppearingDecoration:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    layoutAttributes.alpha = 0.5;
    layoutAttributes.transform3D = CATransform3DMakeTranslation(-CGRectGetWidth(layoutAttributes.frame), 0, 0);
}

@end
