//
//  TableViewController.swift
//  CHXNavigationTransition
//
//  Created by Moch Xiao on 3/16/17.
//  Copyright © 2017 Moch. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.backgroundColor = UIColor.random
        
//        if 0 == _random(in: 0 ..< 100) % 2 {
//            chx_prefersNavigationBarHidden = true
//        } else {
//            chx_prefersNavigationBarHidden = false
//        }
        
        chx_prefersNavigationBarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "\(indexPath.section): \(indexPath.row)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(TableViewController(), animated: true)
    }

}
