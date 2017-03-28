//
//  NextViewController.swift
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 4/20/16.
//  Copyright © 2016 Moch. All rights reserved.
//

import UIKit
import CHXNavigationTransition

public func _random(in range: Range<Int>) -> Int {
    let count = UInt32(range.upperBound - range.lowerBound)
    return  Int(arc4random_uniform(count)) + range.lowerBound
}

public extension UIColor {
    public class var random: UIColor {
        let red   = CGFloat(_random(in: 0 ..< 255))
        let green = CGFloat(_random(in: 0 ..< 255))
        let blue  = CGFloat(_random(in: 0 ..< 255))
        return UIColor.make(red: red, green: green, blue: blue)
    }
    
    public class func make(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 100) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha / 100)
    }
}

class NextViewController: UIViewController {

    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Push", for: .normal)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.frame = CGRect(x: 20, y: 80, width: 60, height: 30)
        actionButton.addTarget(self, action: #selector(NextViewController.push), for: .touchUpInside)
        view.addSubview(actionButton)
        
        if 0 == _random(in: 0 ..< 100) % 2 {
            chx_prefersNavigationBarHidden = true
        } else {
            chx_prefersNavigationBarHidden = false
        }
        chx_prefersNavigationBarHairlineHidden = true
//        chx_prefersInteractivePopGestureRecognizerDisabled = true
    }

    func push() {
        let controller = NextViewController()
        controller.view.backgroundColor = UIColor.random
//        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(RootViewController.back(_:)))
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actionButton.setTitle("\(navigationController!.viewControllers.count)", for: .normal)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        chx_prefersNavigationBarHidden = !chx_prefersNavigationBarHidden
//        chx_setNavigationBarHidden(!chx_prefersNavigationBarHidden, animated: true)
//        chx_prefersStatusBarHidden = !chx_prefersStatusBarHidden
//        chx_prefersNavigationBarHairlineHidden = !chx_prefersNavigationBarHairlineHidden
    }
 }
