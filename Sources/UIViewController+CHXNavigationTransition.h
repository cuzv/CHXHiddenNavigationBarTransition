//
//  UIViewController+CHXNavigationTransition.h
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

#import <UIKit/UIKit.h>

/// All thoese settings only affect current view controller.
@interface UIViewController (CHXNavigationTransition) <UIGestureRecognizerDelegate>

/// Change status bar style, will update immediately when  self's view on window.
/// Otherwise when `viewDidAppear:`.
/// Affect current view controller.
@property (nonatomic, assign) UIStatusBarStyle chx_prefersStatusBarStyle;

/// Set perferred status bar hidden or not. Defatule value is false.
/// Will update state when `viewWillAppear:`, so you need setup before that mehod call.
/// If controller's view on window, will update immediately without animated.
/// Affect current view controller.
@property (nonatomic, assign) BOOL chx_prefersStatusBarHidden;

/// Set perferred navigationBar shoulde hidden or not. Defatule value is false.
/// Will update state when `viewWillAppear:`, so you need setup before that mehod call.
/// If controller's view on window, will update immediately without animated.
/// Affect current view controller.
@property (nonatomic, assign) BOOL chx_prefersNavigationBarHidden;

/// Set navigationBar hidden or not with `interactivePopGestureRecognizer` enabled.
/// Normally you should use `chx_prefersCurrentNavigationBarHidden` property instead of this method.
/// Affect current view controller.
- (void)chx_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

/// Set perferred navigationBar bottom line shoulde hidden or not. Defatule value is false.
/// Will update state when `viewDidAppear:`, so you need setup before that mehod call.
/// If controller's view on window, will update immediately.
/// Affect current view controller.
@property (nonatomic, assign) BOOL chx_prefersNavigationBarHairlineHidden;

/// Disable pop interactive animation, default value is NO.
/// Affect current view controller when self.navigationController.chx_interactivePopGestureRecognizerEnable = YES.
@property (nonatomic, assign) BOOL chx_prefersInteractivePopGestureRecognizerDisabled;

@end

