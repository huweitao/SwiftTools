//
//  UIGestureRecognizer+Statistics.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "UIGestureRecognizer+Statistics.h"
#import "SimpleSwiz.h"
#import <objc/runtime.h>
#import "UnSeedManager.h"

@interface UIGestureRecognizer()

@property (nonatomic, strong) NSString *bindMethodName;

@end

@implementation UIGestureRecognizer (Statistics)

+ (void)load
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:self originalSel:@selector(initWithTarget:action:) replaceSel:@selector(swz_initWithTarget:action:)];
        if (!swzFlag) {
            NSLog(@"Fail to swizzle initWithTarget:action:!");
        }
    });
}

- (instancetype)swz_initWithTarget:(nullable id)target action:(nullable SEL)action
{
    UIGestureRecognizer *selfGestureRecognizer = [self swz_initWithTarget:target action:action];
    if (!target || !action) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return selfGestureRecognizer;
    }
    
    Class class = [target class];
    SEL originalSEL = action;
    
    NSString * sel_name = [UIGestureRecognizer swizzleMethodFrom:[target class] actionName:NSStringFromSelector(action)];
    if (!sel_name) {
        return selfGestureRecognizer;
    }
    
    SEL swizzledSEL = NSSelectorFromString(sel_name);
    // add target class method : selector is "sel_name" and IMP is (responseSWZ_gesture:)
    
    BOOL isAddMethod = class_addMethod(class,
                                       swizzledSEL, method_getImplementation(class_getInstanceMethod([self class], @selector(responseSWZ_gesture:))),
                                       nil);

    // swizzle target added SEL and original SEL
    if (isAddMethod) {
        BOOL swzFlag = [SimpleSwiz simpleSwizzleOriginalClass:class originalSel:originalSEL replaceSel:swizzledSEL];
        if (!swzFlag) {
            return selfGestureRecognizer;
        }

    }

//    NSLog(@"Gesture swizzle:%@<>%@",target,NSStringFromSelector(action));
    // store bindMethodName which is original SEL
    self.bindMethodName = NSStringFromSelector(action);
    return selfGestureRecognizer;
}

// The IMP is added to target class. The self in context is target class instead of UIGestureRecognizer
- (void)responseSWZ_gesture:(UIGestureRecognizer *)gesture
{
//    NSLog(@"Gesture swizzle responseSWZ:%@<>%@",gesture.view,gesture.bindMethodName);
    NSString *identifier = [UIGestureRecognizer swizzleMethodFrom:[self class] actionName:gesture.bindMethodName];
    
    if (!identifier) {
        return;
    }
    
    [UnSeedManager.sharedManager clickTraceBy:identifier];
    
    // call original SEL
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,gesture);
    }
}

+ (NSString *)swizzleMethodFrom:(Class)clazz actionName:(NSString *)actionName
{
    if (!clazz || !actionName) {
        return nil;
    }
    
    NSString *classOCName = [SimpleSwiz filterSwiftClass:clazz];
    return [NSString stringWithFormat:@"%@SWZ_IMP%@", classOCName,actionName];
}

#pragma mark - Property

- (NSString *)bindMethodName
{
    return objc_getAssociatedObject(self, @selector(bindMethodName));
}

- (void)setBindMethodName:(NSString *)bindMethodName
{
    objc_setAssociatedObject(self, @selector(bindMethodName), bindMethodName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
