//
//  ELBaseViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/10/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ELBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func navigationBarWithTitle(navigationTitle: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationItem.title = navigationTitle
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Progress
    func showProgress(){
        NVActivityIndicator.startActivity(self.view, indicatorType: NVActivityIndicatorType.ballSpinFadeLoader)
    }
    
    func hideProgress(){
        NVActivityIndicator.stopActivity(self.view)
    }

}
