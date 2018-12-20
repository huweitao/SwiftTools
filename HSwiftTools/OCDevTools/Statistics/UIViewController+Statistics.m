//
//  UIViewController+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UIViewController+Statistics.h"
#import "SimpleSwiz.h"
#import "UnSeedManager.h"

@implementation UIViewController (Statistics)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        BOOL appearFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(viewDidAppear:) replaceSel:@selector(swz_viewDidAppear:)];
        BOOL disAppearFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(viewWillDisappear:) replaceSel:@selector(swz_viewWillDisappear:)];
        if (!appearFlag) {
            NSLog(@"Fail to swizzle viewDidAppear!");
        }
        if (!disAppearFlag) {
            NSLog(@"Fail to swizzle viewWillDisappear!");
        }
    });
}

- (void)swz_viewDidAppear:(BOOL)animated
{
    NSString *pageKey = [SimpleSwiz filterSwiftClass:self.class];
    NSLog(@"swz_viewDidAppear! %@",pageKey);
    [UnSeedManager.sharedManager startPageMonitorBy:pageKey];
    [self swz_viewDidAppear:animated];
}

- (void)swz_viewWillDisappear:(BOOL)animated
{
    NSString *pageKey = [SimpleSwiz filterSwiftClass:self.class];
    NSLog(@"swz_viewWillDisappear! %@",pageKey);
    [UnSeedManager.sharedManager endPageMonitorBy:pageKey];
    [self swz_viewWillDisappear:animated];
}

@end
