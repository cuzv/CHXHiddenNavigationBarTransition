//
//  CHXMethodSwizzle.m
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 5/25/16.
//  Copyright © 2016 Moch. All rights reserved.
//

#import <objc/runtime.h>

#pragma mark - Swizzle

void _chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector) {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method overrideMethod = class_getInstanceMethod(clazz, overrideSelector);
    if (class_addMethod(clazz, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(clazz, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}