//
//  UINavigationController+CHXNavigationTransition.m
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 5/25/16.
//  Copyright © 2016 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UINavigationController+CHXNavigationTransition.h"
#import <objc/runtime.h>
#import "UIViewController+CHXNavigationTransition.h"

extern void _chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector);

@interface UINavigationController() <UIGestureRecognizerDelegate>
@end

@implementation UINavigationController (CHXNavigationTransition)

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chx_swizzleInstanceMethod([self class], @selector(viewDidLoad), @selector(_chx_viewDidLoad));
    });
}

- (void)_chx_viewDidLoad {
    if (self.chx_interactivePopGestureRecognizerEnable) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    [self _chx_viewDidLoad];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSArray<__kindof UIViewController *> *viewControllers = self.viewControllers;
    if (viewControllers.count <= 1) {
        return NO;
    }
    if (viewControllers.lastObject.chx_prefersInteractivePopGestureRecognizerDisabled) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}

#pragma mark - Accessor

- (BOOL)chx_interactivePopGestureRecognizerEnable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_interactivePopGestureRecognizerEnable:(BOOL)chx_interactivePopGestureRecognizerEnable {
    objc_setAssociatedObject(self,
                             @selector(chx_interactivePopGestureRecognizerEnable),
                             @(chx_interactivePopGestureRecognizerEnable),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
