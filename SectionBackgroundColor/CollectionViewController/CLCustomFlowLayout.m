//
//  CLCustomFlowLayout.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/22.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCustomFlowLayout.h"

static const CGFloat kItemDemension = 140;

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

@end
