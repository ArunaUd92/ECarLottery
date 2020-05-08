//
//  LoginViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
