//
//  UICollectionView+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/20.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UICollectionView+Statistics.h"
#import "SimpleSwiz.h"
#import <objc/runtime.h>
#import "UnSeedManager.h"
#import "UIView+Statistics.h"

@implementation UICollectionView (Statistics)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(setDelegate:) replaceSel:@selector(swz_setDelegate:)];
        if (!swzFlag) {
            NSLog(@"Fail to swizzle UICollectionView setDelegate:!");
        }
        
    });
}

- (void)swz_setDelegate:(id<UICollectionViewDelegate>)delegate
{
    [self swz_setDelegate:delegate];
    
    SEL origSEL = @selector(collectionView:didSelectItemAtIndexPath:);
    
    
    SEL repSELID =  NSSelectorFromString([self swzIdentifierClass:[delegate class] collectionView:self]);
    SEL swzSEL = @selector(swz_collectionView:didSelectItemAtIndexPath:);
    // optional
    if (![SimpleSwiz isContainSel:origSEL inClass:[delegate class]]) {
        return;
    }
    
    BOOL addsuccess = class_addMethod([delegate class],
                                      repSELID,
                                      method_getImplementation(class_getInstanceMethod([self class],swzSEL)),
                                      nil);
    
    //如果添加成功了就直接交换实现， 如果没有添加成功，说明之前已经添加过并交换过实现了
    if (addsuccess) {
        Method selMethod = class_getInstanceMethod([delegate class], origSEL);
        Method sel_Method = class_getInstanceMethod([delegate class], repSELID);
        method_exchangeImplementations(selMethod, sel_Method);
    }
}

#pragma mark - UICollectionView Delegate swizzle
- (void)swz_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString *identifier = [collectionView swzIdentifierClass:[self class] collectionView:collectionView];
    NSLog(@"UICollectionView Select %@ at %ld",identifier,indexPath.row);
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,collectionView,indexPath);
    }
    [UnSeedManager.sharedManager collectionViewSelectByID:identifier tableview:collectionView indexPath:indexPath];
}

- (NSString *)swzIdentifierClass:(Class)clazz collectionView:(UICollectionView *)collectionview
{
    NSString *sTag = self.statisticsTag;
    if (!sTag) {
        sTag = @"IMP";
    }
    return [NSString stringWithFormat:@"%@_%@_%@", [SimpleSwiz filterSwiftClass:clazz],sTag,NSStringFromClass([collectionview class])];
}

@end
