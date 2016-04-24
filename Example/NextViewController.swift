//
//  NextViewController.swift
//  CHXHiddenNavigationBarTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

import UIKit
import CHXHiddenNavigationBarTransition

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        chx_prefersNavigationBarHidden = false
        chx_prefersNavigationBarHairlineHidden = true
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        chx_prefersNavigationBarHidden = !chx_prefersNavigationBarHidden
//        chx_setNavigationBarHidden(!chx_prefersNavigationBarHidden, animated: true)
//        chx_prefersStatusBarHidden = !chx_prefersStatusBarHidden
//        chx_prefersNavigationBarHairlineHidden = !chx_prefersNavigationBarHairlineHidden
    }
 }
