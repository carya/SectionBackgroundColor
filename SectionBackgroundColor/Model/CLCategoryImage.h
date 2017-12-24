//
//  CLCategoryImage.h
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/23.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLCategoryImage : NSObject

@property (nonatomic, strong, readonly) NSArray<UIImage *> *images;
@property (nonatomic, copy, readonly) NSString *category;
@property (nonatomic, assign) BOOL hasFolded;

- (instancetype)initWithImages:(NSArray<UIImage *> *)images category:(NSString *)category;

@end
