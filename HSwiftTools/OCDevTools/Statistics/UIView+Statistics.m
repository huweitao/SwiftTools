//
//  UIView+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/18.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UIView+Statistics.h"
#import <objc/runtime.h>

@implementation UIView (Statistics)

- (void)setStatisticsTag:(NSString *)statisticsTag
{
    objc_setAssociatedObject(self, @selector(statisticsTag), statisticsTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)statisticsTag
{
    return objc_getAssociatedObject(self, @selector(statisticsTag));
}

@end
