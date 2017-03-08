//
//  UIViewController+CHXNavigationTransition.m
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © @2016 Moch Xiao (http://mochxiao.com).
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

#import "UIViewController+CHXNavigationTransition.h"
#import <objc/runtime.h>

extern void _chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector);

@implementation UIViewController (CHXNavigationTransition)

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chx_swizzleInstanceMethod([self class],
                                   @selector(viewWillAppear:),
                                   @selector(_chx_viewWillAppear:));
        _chx_swizzleInstanceMethod([self class],
                                   @selector(viewDidAppear:),
                                   @selector(_chx_viewDidAppear:));
        _chx_swizzleInstanceMethod([self class],
                                   @selector(preferredStatusBarStyle),
                                   @selector(_chx_preferredStatusBarStyle));
        _chx_swizzleInstanceMethod([self class],
                                   @selector(prefersStatusBarHidden),
                                   @selector(_chx_prefersStatusBarHidden));
    });
}

- (void)_chx_viewWillAppear:(BOOL)animated {
    [self _chx_adjustNaivgationBar];
    [self _chx_viewWillAppear:animated];
}

- (void)_chx_viewDidAppear:(BOOL)animated {
    [self setNeedsStatusBarAppearanceUpdate];
    [self _chx_hiddenNavigationBarHairlineIfNeeded];
    [self _chx_viewDidAppear:animated];

}

- (UIStatusBarStyle)_chx_preferredStatusBarStyle {
    if (!self.view.window) {
        return [UIApplication sharedApplication].statusBarStyle;
    }
    return self.chx_prefersStatusBarStyle;
}

- (BOOL)_chx_prefersStatusBarHidden {
    if (!self.view.window) {
        return [UIApplication sharedApplication].statusBarHidden;
    }
    return self.chx_prefersStatusBarHidden;
}

#pragma mark - Public methods

- (BOOL)chx_prefersStatusBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_prefersStatusBarHidden:(BOOL)chx_prefersStatusBarHidden {
    objc_setAssociatedObject(self,
                             @selector(chx_prefersStatusBarHidden),
                             @(chx_prefersStatusBarHidden),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)chx_prefersStatusBarStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setChx_prefersStatusBarStyle:(UIStatusBarStyle)chx_prefersStatusBarStyle {
    objc_setAssociatedObject(self,
                             @selector(chx_prefersStatusBarStyle),
                             @(chx_prefersStatusBarStyle),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (BOOL)chx_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_prefersNavigationBarHidden:(BOOL)chx_prefersNavigationBarHidden {
    objc_setAssociatedObject(self,
                             @selector(chx_prefersNavigationBarHidden),
                             @(chx_prefersNavigationBarHidden),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self _chx_hiddenNavigationBarDependsOnCurrentHidden:self.navigationController.navigationBarHidden
                                               prefersHidden:chx_prefersNavigationBarHidden
                                                    animated:NO];
    }
}

- (void)chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self _chx_setNavigationBarHidden:hidden animated:animated];
    self.chx_prefersNavigationBarHidden = hidden;
}

- (BOOL)chx_prefersNavigationBarHairlineHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_prefersNavigationBarHairlineHidden:(BOOL)chx_prefersNavigationBarHairlineHidden {
    objc_setAssociatedObject(self,
                             @selector(chx_prefersNavigationBarHairlineHidden),
                             @(chx_prefersNavigationBarHairlineHidden),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.view.window) {
        [self _chx_hiddenNavigationBarHairlineIfNeeded];
    }
}

#pragma mark - Helpers

- (void)_chx_adjustNaivgationBar {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    if (!self.navigationController) {
        return;
    }
    [self _chx_hiddenNavigationBarDependsOnCurrentHidden:self.navigationController.navigationBarHidden
                                           prefersHidden:self.chx_prefersNavigationBarHidden
                                                animated:YES];
}

- (void)_chx_hiddenNavigationBarDependsOnCurrentHidden:(BOOL)hidden
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

- (void)_chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];
}

- (void)_chx_hiddenNavigationBarHairlineIfNeeded {
    UIView *hariline = [self _chx_findNavigationBarHairline];
    if (!hariline) {
        return;
    }
    
    BOOL hidden = hariline.hidden;
    BOOL prefers = self.chx_prefersNavigationBarHairlineHidden;
    if (prefers && !hidden) {
        hariline.hidden = YES;
    }
    if (!prefers && hidden) {
        hariline.hidden = NO;
    }
}

- (UIView *)_chx_findNavigationBarHairline {
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    Class clazz1 = NSClassFromString(@"_UINavigationBarBackground");
    Class clazz2 = NSClassFromString(@"_UIBarBackground");
    
    for (UIView *subview in [navigationBar subviews]) {
        if ([subview isKindOfClass:clazz1] || [subview isKindOfClass:clazz2]) {
            for (UIView *line in [subview subviews]) {
                if ([line isKindOfClass:[UIImageView class]] &&
                    line.frame.size.height == 1.0f / [UIScreen mainScreen].scale) {
                    return line;
                }
            }
        }
    }
    
    return nil;
}

- (BOOL)chx_prefersInteractivePopGestureRecognizerDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setChx_prefersInteractivePopGestureRecognizerDisabled:(BOOL)chx_prefersInteractivePopGestureRecognizerDisabled {
    objc_setAssociatedObject(self,
                             @selector(chx_prefersInteractivePopGestureRecognizerDisabled),
                             @(chx_prefersInteractivePopGestureRecognizerDisabled),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
