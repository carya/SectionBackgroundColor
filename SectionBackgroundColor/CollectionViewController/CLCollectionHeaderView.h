//
//  CLCollectionHeaderView.h
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/23.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLCollectionHeaderView;
@protocol CLCollectionHeaderViewDelegate <NSObject>

- (void)headerViewDidTouched:(CLCollectionHeaderView *)headerView;

@end

@interface CLCollectionHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<CLCollectionHeaderViewDelegate> delegate;

- (void)configWithCategory:(NSString *)category;

@end
