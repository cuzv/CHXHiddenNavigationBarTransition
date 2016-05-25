//
//  RootViewController.swift
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

import UIKit
import CHXNavigationTransition

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyanColor()
        
        chx_prefersStatusBarStyle = .LightContent
        chx_prefersNavigationBarHidden = true
        navigationController?.chx_interactivePopGestureRecognizerEnable = true
    }

    @IBAction func handlePushAction(sender: AnyObject) {
        let controller = NextViewController()
        controller.view.backgroundColor = UIColor.orangeColor()
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RootViewController.back(_:)))
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    internal dynamic func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
