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
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *chx_interactivePopGestureRecognizer;
@end

@implementation UINavigationController (CHXNavigationTransition)

#pragma mark - Hook

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _chx_swizzleInstanceMethod([self class], @selector(pushViewController:animated:), @selector(_chx_pushViewController:animated:));
    });
}

// stolen from https://github.com/forkingdog/FDFullscreenPopGesture
- (void)_chx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.chx_interactivePopGestureRecognizerEnable &&
        ![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.chx_interactivePopGestureRecognizer]) {
         // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.chx_interactivePopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        [self.chx_interactivePopGestureRecognizer addTarget:[internalTargets.firstObject valueForKey:@"target"]
                                                     action:NSSelectorFromString(@"handleNavigationTransition:")];
        self.chx_interactivePopGestureRecognizer.delegate = self;
        
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Forward to primary implementation.
    if (![self.viewControllers containsObject:viewController]) {
        [self _chx_pushViewController:viewController animated:animated];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    if (self.viewControllers.lastObject.chx_prefersInteractivePopGestureRecognizerDisabled) {
        return NO;
    }
    return YES;
}

#pragma mark - Accessor

- (UIScreenEdgePanGestureRecognizer *)chx_interactivePopGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [UIScreenEdgePanGestureRecognizer new];
        gesture.edges = UIRectEdgeLeft;
        gesture.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gesture;
}

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
