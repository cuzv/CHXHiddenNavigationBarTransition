//
//  RootViewController.swift
//  CHXHiddenNavigationBarTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

import UIKit
import CHXHiddenNavigationBarTransition

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        chx_prefersdStatusBarStyle = .LightContent
        chx_prefersCurrentNavigationBarHidden = true
    }

}
