//
//  CLCollectionViewFlowLayout.m
//  SectionBackgroundColor
//
//  Created by CaryaLiu on 2017/11/28.
//  Copyright © 2017年 CaryaLiu. All rights reserved.
//

#import "CLCollectionViewFlowLayout.h"
#import "CLSectionColorLayoutAttributes.h"
#import "CLCollectionSectionBackgroundView.h"

static const CGFloat kItemDemension = 140;
static NSString *const kDecorationViewKind = @"CLCollectionSectionBackgroundView";

@interface CLCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *,UICollectionViewLayoutAttributes *> *decorationViewAttributes;

@end

@implementation CLCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kItemDemension, kItemDemension);
        self.sectionInset = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
        self.minimumLineSpacing = 15.0f;
        self.minimumInteritemSpacing = 15.0f;
        
        [self registerClass:[CLCollectionSectionBackgroundView class] forDecorationViewOfKind:kDecorationViewKind];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    [self prepareDecorationViewAttributes];
}

+ (Class)layoutAttributesClass {
    return [CLSectionColorLayoutAttributes class];
}

#pragma mark - override methods

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    [self.decorationViewAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * _Nonnull key, UICollectionViewLayoutAttributes * _Nonnull obj, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [attributes addObject:obj];
        }
    }];
    
    return attributes;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

#pragma mark - private methods

- (void)applyLayoutAttributes:(CLSectionColorLayoutAttributes *)attributes {
    
}

- (void)prepareDecorationViewAttributes {
    
    NSInteger numOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numOfSections; ++section) {
        
        NSInteger numOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numOfItems > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:numOfItems - 1 inSection:section];
            UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:indexPath];
            UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:lastIndexPath];
            
            UIEdgeInsets sectionInset = self.sectionInset;
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                id<UICollectionViewDelegateFlowLayout> flowLayout = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
                sectionInset = [flowLayout collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            }
            
            //calculate the frame of section background view
            CGRect frame = CGRectUnion(firstItem.frame, lastItem.frame);
            frame.origin.x -= sectionInset.left;
            frame.origin.y -= sectionInset.top;
            if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                frame.size.width += sectionInset.left + sectionInset.right;
                frame.size.height = self.collectionView.frame.size.height;
            } else {
                frame.size.width = self.collectionView.frame.size.width;
                frame.size.height += sectionInset.top + sectionInset.bottom;
            }
            NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:section];
            CLSectionColorLayoutAttributes *decorationViewAttributes = [CLSectionColorLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationViewKind withIndexPath:sectionIndexPath];
            decorationViewAttributes.frame = frame;
            decorationViewAttributes.zIndex = -1;
            decorationViewAttributes.sectionColor = self.sectionColor;
            //if implemented collectionView:layout:colorForSectionAtIndex: use the return value
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:colorForSectionAtIndex:)]) {
                id<CLCollectionViewDelegateFlowLayout> temp = (id<CLCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
                decorationViewAttributes.sectionColor = [temp collectionView:self.collectionView layout:self colorForSectionAtIndex:decorationViewAttributes.indexPath.section];
            }
            self.decorationViewAttributes[sectionIndexPath] = decorationViewAttributes;
        }
    }
}

#pragma mark - setter

- (void)setSectionColor:(UIColor *)sectionColor {
    _sectionColor = sectionColor;
    [self invalidateLayout];
}

#pragma mark - getter & setter

- (NSMutableDictionary<NSIndexPath *,UICollectionViewLayoutAttributes *> *)decorationViewAttributes {
    if (!_decorationViewAttributes) {
        _decorationViewAttributes = @{}.mutableCopy;
    }
    
    return _decorationViewAttributes;
}

@end
