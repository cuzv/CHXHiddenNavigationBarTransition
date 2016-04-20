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

        chx_prefersCurrentNavigationBarHidden = false
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        chx_prefersCurrentNavigationBarHidden = !chx_prefersCurrentNavigationBarHidden
        chx_setNavigationBarHidden(!chx_prefersCurrentNavigationBarHidden, animated: true)
        
    }
 }
