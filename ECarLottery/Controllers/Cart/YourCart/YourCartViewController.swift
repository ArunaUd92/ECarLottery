//
//  YourCartViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/13/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class YourCartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.estimatedRowHeight = 506.0
        cartTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: Button event action
    @IBAction func btnBackAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Table View DataSource
extension YourCartViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCartTableViewCell", for: indexPath) as! YourCartTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

// MARK: - Table View Delegate
extension YourCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
