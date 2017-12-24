//
//  CLCategoryImage.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/23.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCategoryImage.h"

@interface CLCategoryImage ()

@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, copy) NSString *category;

@end

@implementation CLCategoryImage

- (instancetype)initWithImages:(NSArray<UIImage *> *)images category:(NSString *)category {
    self = [super init];
    if (self) {
        self.images = images;
        self.category = category;
        self.hasFolded = NO;
    }
    
    return self;
}

@end
