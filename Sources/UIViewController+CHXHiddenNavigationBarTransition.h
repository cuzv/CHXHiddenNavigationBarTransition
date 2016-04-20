//
//  UIViewController+CHXHiddenNavigationBarTransition.h
//  CHXHiddenNavigationBarTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CHXHiddenNavigationBarTransition) <UIGestureRecognizerDelegate>

/// Change status bar style, will update immediately when  self's view on window.
/// Otherwise when `viewDidAppear:`.
@property (nonatomic, assign) UIStatusBarStyle chx_prefersdStatusBarStyle;

/// Set perferred current controller navigationBar shoulde hidden or not. Defatule value is false.
/// Will update state when `viewWillAppear:`, so you need setup before that mehod call.
/// If controller's view on window, will update immediately without animated.
@property (nonatomic, assign) BOOL chx_prefersCurrentNavigationBarHidden;

/// Set navigationBar hidden or not with `interactivePopGestureRecognizer` enabled.
/// Normally you should use `chx_prefersCurrentNavigationBarHidden` property instead of this method.
- (void)chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
