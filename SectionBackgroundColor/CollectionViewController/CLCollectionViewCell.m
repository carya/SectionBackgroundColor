//
//  CLCollectionViewCell.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/16.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCollectionViewCell.h"

@interface CLCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation CLCollectionViewCell

- (void)configWithImg:(UIImage *)img {
    self.imgView.image = img;
}

@end
