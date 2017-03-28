[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/cuzv/PhotoBrowser/blob/master/LICENSE)
[![CocoaPods Compatible](https://img.shields.io/badge/CocoaPods-v0.4.0-green.svg)](https://github.com/CocoaPods/CocoaPods)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Weibo](https://img.shields.io/badge/Weibo-cuzval-yellowgreen.svg)](http://weibo.com/cuzval/)
[![Twitter](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](http://twitter.com/mochxiao)

# CHXNavigationTransition

Deal with navigation bar and status bar animation when some page set navigation bar hidden or change status bar style. Enable slide-back when you use leftBarButtonItem.

### Deprecated

Replace by [RRNavigationBar](https://github.com/cuzv/RRNavigationBar).



ViewController preferredStatusBarStyle 设置生效的前置条件

- Info.plis -> View controller-based status bar appearance -> YES
- 当 ViewController 处于 NavigationController stack 中时设置 preferredStatusBarStyle 无效，是因为获取到 NavigationController 的 preferredStatusBarStyle 了
