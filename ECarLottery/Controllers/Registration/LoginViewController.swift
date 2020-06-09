//
//  LoginViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class LoginViewController: ELBaseViewController {
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func postLogin() {
        
        guard let email = txtEmail.text, !email.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Email field cannot be empty.")
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Password field cannot be empty.")
            return
        }
        
        let checkValidEmail = ValidatorHelper.validateEmail(email: txtEmail.text!)
        if(!checkValidEmail) {
            ELMessageView.showMessage(type: ELMessageView.ErrorMessage, title: "Error", message: "Invalid Email.")
            return
        }
        
        if !(NetworkReachabilityManager()?.isReachable)! {
            self.popupAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                self.postLogin()
                }, { action2 in
                    
                }, nil])
            
        } else {
            
            let authService = AuthService()
            self.showProgress()
            authService.postLogin(email: self.txtEmail.text!, password: self.txtPassword.text!, onSuccess: { () -> Void in
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let registrationVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        registrationVC.modalPresentationStyle = .fullScreen
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let resetPasswordVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        resetPasswordVC.modalPresentationStyle = .fullScreen
        self.present(resetPasswordVC, animated: true, completion: nil)
    }
}
