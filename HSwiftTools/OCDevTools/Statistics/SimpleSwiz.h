//
//  SimpleSwiz.h
//  GCash
//
//  Created by huweitao on 2018/12/13.
//  Copyright © 2018年 GXI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleSwiz : NSObject

+ (BOOL)simpleSwizzleOriginalClass:(Class)aClass originalSel:(SEL)originalSel replaceSel:(SEL)swizzleSel;

+ (NSString *)filterSwiftClass:(Class)clazz;

+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class;

@end

NS_ASSUME_NONNULL_END
