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

        view.backgroundColor = UIColor.cyan
        
        chx_prefersStatusBarStyle = .lightContent
//        chx_prefersNavigationBarHidden = true
        navigationController?.chx_interactivePopGestureRecognizerEnabled = true
    }

    @IBAction func handlePush(_ sender: UIButton) {
//        let controller = NextViewController()
        let controller = TableViewController()
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back(sender:)))
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    internal dynamic func back(sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
