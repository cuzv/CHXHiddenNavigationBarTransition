//
//  NextViewController.swift
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

import UIKit
import CHXNavigationTransition

class NextViewController: UIViewController {

    let actionButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Push", forState: .Normal)
        button.backgroundColor = UIColor.cyanColor()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.frame = CGRectMake(20, 80, 60, 30)
        actionButton.addTarget(self, action: #selector(NextViewController.push), forControlEvents: .TouchUpInside)
        view.addSubview(actionButton)
        
        chx_prefersNavigationBarHidden = true
//        chx_prefersNavigationBarHairlineHidden = true
//        chx_prefersInteractivePopGestureRecognizerDisabled = true
    }

    func push() {
        let controller = NextViewController()
        controller.view.backgroundColor = UIColor.orangeColor()
//        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RootViewController.back(_:)))
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        actionButton.setTitle("\(navigationController!.viewControllers.count)", forState: .Normal)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        chx_prefersNavigationBarHidden = !chx_prefersNavigationBarHidden
//        chx_setNavigationBarHidden(!chx_prefersNavigationBarHidden, animated: true)
//        chx_prefersStatusBarHidden = !chx_prefersStatusBarHidden
//        chx_prefersNavigationBarHairlineHidden = !chx_prefersNavigationBarHairlineHidden
    }
 }
