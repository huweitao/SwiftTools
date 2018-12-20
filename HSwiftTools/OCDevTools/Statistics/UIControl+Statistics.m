//
//  UIControl+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UIControl+Statistics.h"
#import "SimpleSwiz.h"
#import "UnSeedManager.h"

@implementation UIControl (Statistics)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(sendAction:to:forEvent:) replaceSel:@selector(swz_sendAction:to:forEvent:)];
        if (!swzFlag) {
            NSLog(@"Fail to swizzle sendAction:to:forEvent:!");
        }
    });
}

-(void)swz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSString *ocClass = [SimpleSwiz filterSwiftClass:[target class]];
    NSString *identifier = [NSString stringWithFormat:@"%@_%@", ocClass, NSStringFromSelector(action)];
    NSLog(@"swz_sendAction! %@",identifier);
    [UnSeedManager.sharedManager clickTraceBy:identifier];
    [self swz_sendAction:action to:target forEvent:event];
}

@end
