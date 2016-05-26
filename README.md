[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/cuzv/PhotoBrowser/blob/master/LICENSE)
[![CocoaPods Compatible](https://img.shields.io/badge/CocoaPods-v0.4.1-green.svg)](https://github.com/CocoaPods/CocoaPods)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Weibo](https://img.shields.io/badge/Weibo-cuzval-yellowgreen.svg)](http://weibo.com/cuzval/)
[![Twitter](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](http://twitter.com/mochxiao)

# CHXNavigationTransition

Deal with navigation bar and status bar animation when some page set navigation bar hidden or change status bar style. Enable slide-back when you use leftBarButtonItem.



ViewController preferredStatusBarStyle() 设置生效的前置条件

- Info.plis -> View controller-based status bar appearance -> YES
- navigationBarHidden = true


NavigationBar 没有隐藏的时候设置 preferredStatusBarStyle 无效。
NavigationBar 隐藏后才会根据 preferredStatusBarStyle 来更新状态栏

override preferredStatusBarStyle 记得调用 super


```
 override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        return .Default
 }
```

**注意**：不要覆盖该方法，请直接使用 `chx_prefersdStatusBarStyle` 属性.

