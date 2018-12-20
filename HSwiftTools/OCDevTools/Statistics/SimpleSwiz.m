//
//  SimpleSwiz.m
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import "SimpleSwiz.h"
#import <objc/runtime.h>

@implementation SimpleSwiz

+ (BOOL)simpleSwizzleOriginalClass:(Class)aClass originalSel:(SEL)originalSel replaceSel:(SEL)swizzleSel {
    
    return [self simpleSwizzleOriginalClass:aClass originalSel:originalSel replaceClass:aClass replaceSel:swizzleSel];
}

+ (NSString *)filterSwiftClass:(Class)clazz
{
    NSString *classString = NSStringFromClass(clazz);
    NSArray *elements = [classString componentsSeparatedByString:@"."];
    if (elements.count > 0) {
        classString = elements.lastObject;
    }
    return classString;
}

// if class implemented sel
+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Private

+ (BOOL)simpleSwizzleOriginalClass:(Class)origClass originalSel:(SEL)origSel replaceClass:(Class)newClass replaceSel:(SEL)newSel {
    
    Method origMethod = class_getInstanceMethod(origClass, origSel);
    if (!origMethod) {
        NSLog(@"Original method %@ not found for class %@", NSStringFromSelector(origSel), [origClass class]);
        return NO;
    }
    
    Method newMethod = class_getInstanceMethod(newClass, newSel);
    if (!newMethod) {
        NSLog( @"New method %@ not found for class %@", NSStringFromSelector(newSel), [newClass class]);
        return NO;
    }
    
    // origClass如果没有origSel，alert
    if (class_addMethod(origClass,origSel,class_getMethodImplementation(origClass, origSel),method_getTypeEncoding(origMethod))) {
        NSLog(@"Original method %@ is is not owned by class %@",NSStringFromSelector(origSel), [origClass class]);
        return NO;
    }
    
    // 如果不是同一个类，需要添加method
    if (![NSStringFromClass(origClass) isEqualToString:NSStringFromClass(newClass)]) {
        if (!class_addMethod(origClass,newSel,class_getMethodImplementation(newClass, newSel),method_getTypeEncoding(newMethod))) {
            NSLog(@"New method %@ can not be added in class %@",NSStringFromSelector(newSel), [newClass class]);
        }
    }
    
    method_exchangeImplementations(class_getInstanceMethod(origClass, origSel), class_getInstanceMethod(origClass, newSel));
    
    return YES;
}

@end
