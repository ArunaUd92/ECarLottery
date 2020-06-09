//
//  ResetPasswordViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class ResetPasswordViewController: ELBaseViewController {
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func postResetPassword() {
        
        guard let email = txtEmail.text, !email.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Email field cannot be empty.")
            return
        }
        
        let checkValidEmail = ValidatorHelper.validateEmail(email: txtEmail.text!)
        if(!checkValidEmail) {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Invalid Email.")
            return
        }
        
        
        if !(NetworkReachabilityManager()?.isReachable)! {
            self.popupAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                self.postResetPassword()
                }, { action2 in
                    
                }, nil])
            
        } else {
            
            let authService = AuthService()
            self.showProgress()
            authService.postResetPassword(email: self.txtEmail.text!, onSuccess: { () -> Void in
                self.hideProgress()
                
                
                
                
            }, onResponseError: { (error: String, code: Bool) -> Void in
                print(error)
                self.hideProgress()
                ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: error)
                
            }, onError: { (error: String, code: Int) -> Void in
                print(error)
                self.hideProgress()
                ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: error)
            })
        }
    }
    
    // MARK: Button event action
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
       postResetPassword()
    }
}
