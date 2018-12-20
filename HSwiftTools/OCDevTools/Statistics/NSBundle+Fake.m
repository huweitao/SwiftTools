//
//  NSBundle+Fake.m
//  GCash
//
//  Created by huweitao on 2018/12/14.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "NSBundle+Fake.h"
#import "SimpleSwiz.h"

static NSMutableDictionary *fakeMutableDictionary = nil;

//static inline BOOL shouldUseFake(NSArray *):callStackSymbols
//{
//
//}

@implementation NSBundle (Fake)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(infoDictionary) replaceSel:@selector(swz_infoDictionary)];
        if (!swzFlag) {
            NSLog(@"Fail to swizzle infoDictionary!");
        }
    });
}

- (NSDictionary *)swz_infoDictionary
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        fakeMutableDictionary = [[self swz_infoDictionary] mutableCopy];
        NSString *cfType = fakeMutableDictionary[@"CFBundleExecutable"];
        NSString *fakeID = [self projEnviromentAndIDs][cfType];
        if (fakeID) {
            fakeMutableDictionary[@"CFBundleIdentifier"] = fakeID;
        }
    });
    NSArray *stackTraces = [NSThread callStackSymbols];
//    NSLog(@"Stack trace:%@",stackTraces);
    if ([self shouldUseFakeIDFromStackSymbols:stackTraces]) {
        return fakeMutableDictionary;
    }
    else {
        return [self swz_infoDictionary];
    }
}

- (NSDictionary *)projEnviromentAndIDs {
    return @{
             @"Prod":@"prod",
             @"Dev":@"dev",
             };
}

- (BOOL)shouldUseFakeIDFromStackSymbols:(NSArray *)callStackSymbols
{
    if (!callStackSymbols || callStackSymbols.count == 0) {
        return NO;
    }
    for (NSString *symb in callStackSymbols) {
        // [symb containsString:@"IAPConfiguration"]
    }
    return NO;
}


@end
