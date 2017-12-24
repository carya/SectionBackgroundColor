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

static NSString *const kDecorationViewKind = @"CLCollectionSectionBackgroundView";

@interface CLCollectionViewFlowLayout ()

@property (nonatomic, weak) id<CLCollectionViewFlowLayoutUpdateHooks> child;

@property (nonatomic, strong) NSMutableSet *deleteSectionSet;

@property (nonatomic, strong) NSMutableSet *insertSectionSet;

@end

@implementation CLCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerClass:[CLCollectionSectionBackgroundView class] forDecorationViewOfKind:kDecorationViewKind];
        if ([self conformsToProtocol:@protocol(CLCollectionViewFlowLayoutUpdateHooks)]) {
            self.child = (id<CLCollectionViewFlowLayoutUpdateHooks>)self;
        }
    }
    return self;
}

+ (Class)layoutAttributesClass {
    return [CLSectionColorLayoutAttributes class];
}

#pragma mark - override methods

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributes = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    NSMutableArray<UICollectionViewLayoutAttributes *> *newAttributes = @[].mutableCopy;
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSIndexPath *indexPath = obj.indexPath;
        /**< make sure each section only add decoration view layout attributes once */
        if (indexPath.item == 0 && [self.collectionView numberOfItemsInSection:indexPath.section] > 0) {
            UICollectionViewLayoutAttributes *temp = [self layoutAttributesForDecorationViewOfKind:kDecorationViewKind atIndexPath:obj.indexPath];
            [newAttributes addObject:temp];
        }
    }];
    
    [attributes addObjectsFromArray:newAttributes];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if (![elementKind isEqualToString:kDecorationViewKind]) {
        return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
    }
    NSInteger section = indexPath.section;
    NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:section];
    CLSectionColorLayoutAttributes *decorationViewAttributes = [CLSectionColorLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationViewKind withIndexPath:sectionIndexPath];
    
    NSInteger numOfItems = [self.collectionView numberOfItemsInSection:section];
    if (numOfItems > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:numOfItems - 1 inSection:section];
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:indexPath];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:lastIndexPath];
        
        UIEdgeInsets sectionInset = [self sectionInsetAtSection:section];
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
        
        decorationViewAttributes.frame = frame;
        decorationViewAttributes.zIndex = -1;
        decorationViewAttributes.sectionColor = [self sectionColorAtSection:decorationViewAttributes.indexPath.section];
    }
    return  decorationViewAttributes;
}

/** The collection view calls the following two method between its calls to prepareForCollectionViewUpdates: and finalizeCollectionViewUpdates. */
- (NSArray<NSIndexPath *> *)indexPathsToInsertForDecorationViewOfKind:(NSString *)elementKind {
    NSMutableArray<NSIndexPath *> *temp = @[].mutableCopy;
    [self.insertSectionSet enumerateObjectsUsingBlock:^(NSNumber  * _Nonnull section, BOOL * _Nonnull stop) {
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:section.integerValue];
        [temp addObject:sectionIndexPath];
    }];
    
    return temp;
}

- (NSArray<NSIndexPath *> *)indexPathsToDeleteForDecorationViewOfKind:(NSString *)elementKind {
    
    NSMutableArray<NSIndexPath *> *temp = @[].mutableCopy;
    [self.deleteSectionSet enumerateObjectsUsingBlock:^(NSNumber  * _Nonnull section, BOOL * _Nonnull stop) {
        NSIndexPath *sectionIndexPath = [NSIndexPath indexPathWithIndex:section.integerValue];
        [temp addObject:sectionIndexPath];
    }];
    
    return temp;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
    UICollectionViewLayoutAttributes *layoutAttributes;
    if ([elementKind isEqualToString:kDecorationViewKind]) {
        if ([self.insertSectionSet containsObject:@(decorationIndexPath.section)]) {
            layoutAttributes = [self layoutAttributesForDecorationViewOfKind:kDecorationViewKind atIndexPath:decorationIndexPath];
            if (self.child) {
                
            } else {
                layoutAttributes.alpha = 0;
                layoutAttributes.transform3D = CATransform3DMakeTranslation(-CGRectGetWidth(layoutAttributes.frame), 0, 0);
            }
        }
    }
    return layoutAttributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem * _Nonnull updateItem, NSUInteger idx, BOOL * _Nonnull stop) {
        if (updateItem.updateAction == UICollectionUpdateActionDelete) {
            [self.deleteSectionSet addObject:@(updateItem.indexPathBeforeUpdate.section)];
        } else if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            [self.insertSectionSet addObject:@(updateItem.indexPathAfterUpdate.section)];
        }
    }];
}

- (void)finalizeCollectionViewUpdates {
    [super finalizeCollectionViewUpdates];
    
    [self.insertSectionSet removeAllObjects];
    [self.deleteSectionSet removeAllObjects];
}

#pragma mark - private methods

- (UIEdgeInsets)sectionInsetAtSection:(NSInteger)section {
    UIEdgeInsets sectionInset = self.sectionInset;
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> flowLayout = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        sectionInset = [flowLayout collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return sectionInset;
}

- (UIColor *)sectionColorAtSection:(NSInteger)section {
    
    UIColor *sectionColor = self.sectionColor;
    //if implemented collectionView:layout:colorForSectionAtIndex: use the return value
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:colorForSectionAtIndex:)]) {
        id<CLCollectionViewDelegateFlowLayout> temp = (id<CLCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
        sectionColor = [temp collectionView:self.collectionView layout:self colorForSectionAtIndex:section];
    }
    return sectionColor;
}

#pragma mark - getter & setter

- (void)setSectionColor:(UIColor *)sectionColor {
    _sectionColor = sectionColor;
    [self invalidateLayout];
}

- (NSMutableSet *)deleteSectionSet {
    if (!_deleteSectionSet) {
        _deleteSectionSet = [NSMutableSet set];
    }
    return _deleteSectionSet;
}

- (NSMutableSet *)insertSectionSet {
    if (!_insertSectionSet) {
        _insertSectionSet = [NSMutableSet set];
    }
    return _insertSectionSet;
}

@end
