//
//  ELBaseViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/10/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit

class ELBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func navigationBarWithTitle(navigationTitle: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = navigationTitle
    }

}
