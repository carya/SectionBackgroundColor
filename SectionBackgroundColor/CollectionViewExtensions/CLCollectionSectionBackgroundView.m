//
//  CLCollectionSectionBackgroundView.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/12/16.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCollectionSectionBackgroundView.h"
#import "CLSectionColorLayoutAttributes.h"

@implementation CLCollectionSectionBackgroundView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if ([layoutAttributes isKindOfClass:[CLSectionColorLayoutAttributes class]]) {
        CLSectionColorLayoutAttributes *attributes = (CLSectionColorLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attributes.sectionColor;
    }
}

@end
