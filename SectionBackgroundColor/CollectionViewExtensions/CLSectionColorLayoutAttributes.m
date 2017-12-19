//
//  CLSectionColorLayoutAttributes.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/11/28.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLSectionColorLayoutAttributes.h"

@implementation CLSectionColorLayoutAttributes

/** subclass must conforms to the NSCopying protocol */
- (id)copyWithZone:(NSZone *)zone {
    
    CLSectionColorLayoutAttributes *layoutAttributes = [super copyWithZone:zone];
    layoutAttributes.sectionColor = self.sectionColor;
    return layoutAttributes;
}

/** In iOS 7 and later, the collection view does not apply layout attributes if
 those attributes have not changed. It determines whether the attributes have changed
 by comparing the old and new attribute objects using the isEqual: method. */
- (BOOL)isEqual:(id)object {
    
    if (self == object) {
        return YES;
    }
    
    if ([object class] == [self class]) {
        return [super isEqual:object] && (self.sectionColor == [object sectionColor]);
    }
    return NO;
}

@end
