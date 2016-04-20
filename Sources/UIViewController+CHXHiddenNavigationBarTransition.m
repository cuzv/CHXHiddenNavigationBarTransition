//
//  UIViewController+CHXHiddenNavigationBarTransition.m
//  CHXHiddenNavigationBarTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

#import "UIViewController+CHXHiddenNavigationBarTransition.h"
#import <objc/runtime.h>

void _chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector);

@implementation UIViewController (CHXHiddenNavigationBarTransition)

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chx_swizzleInstanceMethod([self class], @selector(viewWillAppear:), @selector(_chx_viewWillAppear:));
        _chx_swizzleInstanceMethod([self class], @selector(viewDidAppear:), @selector(_chx_viewDidAppear:));
        _chx_swizzleInstanceMethod([self class], @selector(preferredStatusBarStyle), @selector(_chx_preferredStatusBarStyle));
    });
}

- (void)_chx_viewWillAppear:(BOOL)animated {
    [self _chx_adjustNaivgationBar];
    [self _chx_viewWillAppear:animated];
}

- (void)_chx_adjustNaivgationBar {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    if (!self.navigationController) {
        return;
    }
    [self _chx_hiddenCurrentNavigationBarDependsOnCurrentHidden:self.navigationController.navigationBarHidden
                                                  prefersHidden:self.chx_prefersCurrentNavigationBarHidden
                                                       animated:YES];
}

- (void)_chx_hiddenCurrentNavigationBarDependsOnCurrentHidden:(BOOL)hidden
                                                prefersHidden:(BOOL)prefers
                                                     animated: (BOOL)animated
{
    if (prefers && !hidden) {
        [self _chx_setNavigationBarHidden:YES animated:animated];
    }
    if (!prefers && hidden) {
        [self _chx_setNavigationBarHidden:NO animated:animated];
    }
}

- (void)_chx_viewDidAppear:(BOOL)animated {
    [self setNeedsStatusBarAppearanceUpdate];
    [self _chx_viewDidAppear:animated];
}

- (UIStatusBarStyle)_chx_preferredStatusBarStyle {
    if (!self.view.window) {
        return  [UIApplication sharedApplication].statusBarStyle;
    }
    return self.chx_prefersdStatusBarStyle;
}

#pragma mark - Public methods

- (UIStatusBarStyle)chx_prefersdStatusBarStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setChx_prefersdStatusBarStyle:(UIStatusBarStyle)chx_prefersdStatusBarStyle {
    objc_setAssociatedObject(self, @selector(chx_prefersdStatusBarStyle), @(chx_prefersdStatusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (BOOL)chx_prefersCurrentNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_prefersCurrentNavigationBarHidden:(BOOL)chx_prefersCurrentNavigationBarHidden {
    objc_setAssociatedObject(self, @selector(chx_prefersCurrentNavigationBarHidden), @(chx_prefersCurrentNavigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self _chx_hiddenCurrentNavigationBarDependsOnCurrentHidden:self.navigationController.navigationBarHidden
                                                      prefersHidden:chx_prefersCurrentNavigationBarHidden
                                                           animated:NO];
    }
}

- (void)chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self _chx_setNavigationBarHidden:hidden animated:animated];
    self.chx_prefersCurrentNavigationBarHidden = hidden;
}

- (void)_chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

@end

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