# CHXHiddenNavigationBarTransition
Deal with navigation bar and status bar animation when some page set navigation bar hidden or change status bar style.



ViewController preferredStatusBarStyle() 设置生效的前置条件
- Info.plis -> View controller-based status bar appearance -> YES
- navigationBarHidden = true


NavigationBar 没有隐藏的时候设置 preferredStatusBarStyle 无效
NavigationBar 隐藏后才会根据 preferredStatusBarStyle 来更新状态栏

override preferredStatusBarStyle 记得调用 super


```
 override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        return .Default
 }
```

不要覆盖该方法，直接使用 chx_prefersdStatusBarStyle.

