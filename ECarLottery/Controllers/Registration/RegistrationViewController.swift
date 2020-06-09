//
//  RegistrationViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class RegistrationViewController: ELBaseViewController {
    
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func postRegistration() {
        
        guard let firstName = txtFirstName.text, !firstName.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "First Name field cannot be empty.")
            return
        }
        
        guard let lastName = txtLastName.text, !lastName.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Last Name field cannot be empty.")
            return
        }
        
        guard let email = txtEmail.text, !email.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Email field cannot be empty.")
            return
        }
        
        let checkValidEmail = ValidatorHelper.validateEmail(email: txtEmail.text!)
        if(!checkValidEmail) {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Invalid Email.")
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Password field cannot be empty.")
            return
        }
        
        guard let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Password field cannot be empty.")
            return
        }
        
        if(txtPassword.text != txtConfirmPassword.text) {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Password does not match the confirm password.")
            return
        }
        
        if !(NetworkReachabilityManager()?.isReachable)! {
            self.popupAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                self.postRegistration()
                }, { action2 in
                    
                }, nil])
            
        } else {
            
            let authService = AuthService()
            self.showProgress()
            authService.postRegistration(firstName: txtFirstName.text!, lastName: txtLastName.text!, email: txtEmail.text!, password: txtPassword.text!, onSuccess: { () -> Void in
                self.hideProgress()
                
                let storyboard = UIStoryboard(name: "Register", bundle: nil)
                let verificationVC = storyboard.instantiateViewController(withIdentifier: "OTPVerificationViewController") as! OTPVerificationViewController
                verificationVC.modalPresentationStyle = .fullScreen
                verificationVC.userEmail = self.txtEmail.text!
                self.present(verificationVC, animated: true, completion: nil)
                
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
    
    @IBAction func registrationAction(_ sender: Any) {
        postRegistration()
    }
    
}
