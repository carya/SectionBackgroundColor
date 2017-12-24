//
//  CLCollectionHeaderView.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/23.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCollectionHeaderView.h"

@interface CLCollectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation CLCollectionHeaderView

- (void)configWithCategory:(NSString *)category {
    self.categoryLabel.text = category;
}

- (IBAction)headerViewDidTouched:(id)sender {
    [self.delegate headerViewDidTouched:self];
}

@end
