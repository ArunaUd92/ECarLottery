//
//  OTPVerificationViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 6/8/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import Alamofire

class OTPVerificationViewController: ELBaseViewController, MyTextFieldDelegate {

    @IBOutlet weak var txt1: MyTextField!
    @IBOutlet weak var txt2: MyTextField!
    @IBOutlet weak var txt3: MyTextField!
    @IBOutlet weak var txt4: MyTextField!
    @IBOutlet weak var txt5: MyTextField!
    @IBOutlet weak var txt6: MyTextField!
    var currentTextFiled:MyTextField! = nil
    var userEmail: String = ""
    
    @IBOutlet weak var btnResend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUptextFieldDelegate()

    }
    
    func postVerification() {
        
        self.view.endEditing(true)
        if self.txt1.text!.isEmpty || self.txt2.text!.isEmpty || self.txt3.text!.isEmpty || self.txt4.text!.isEmpty || self.txt5.text!.isEmpty || self.txt6.text!.isEmpty {
            ELMessageView.showMessage(type: ELMessageView.InfoMessage, title: "Info", message: "Please Enter OTP.")
            return
        }
        
        let strOTP = "\(self.txt1.text!)\(self.txt2.text!)\(self.txt3.text!)\(self.txt4.text!)\(self.txt5.text!)\(self.txt6.text!)"

        if !(NetworkReachabilityManager()?.isReachable)! {
            self.popupAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                self.postVerification()
                }, { action2 in
                    
                }, nil])
            
        } else {
            
            let authService = AuthService()
            self.showProgress()
            authService.postOTPVerification(email: userEmail, otpCode: strOTP, onSuccess: { () -> Void in
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
    
    private func setUptextFieldDelegate(){
        
        txt1.myDelegate = self
        txt2.myDelegate = self
        txt3.myDelegate = self
        txt4.myDelegate = self
        txt5.myDelegate = self
        txt6.myDelegate = self
        
        txt1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        txt6.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        txt1.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        txt2.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        txt3.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        txt4.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        txt5.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        txt6.addTarget(self, action: #selector(myTargetFunction(textField:)), for: .touchDown)
        currentTextFiled = txt1
    }

     // MARK: Button event action
    @IBAction func verificationAction(_ sender: Any) {
        self.postVerification()
    }
}

//MARK: Textfield Delegate
extension OTPVerificationViewController : UITextFieldDelegate {
    func textFieldDidDelete() {
        if(currentTextFiled == txt1)
        {
            if(txt1.text!.count > 0 )
            {
                txt1.text = ""
                currentTextFiled = txt1
            }
            else
            {
                self.view.endEditing(true)
            }
        }
        else if(currentTextFiled == txt2)
        {
            if(txt2.text!.count > 0 )
            {
                txt2.text = ""
            }
            else
            {
                txt1.text = ""
                txt1.becomeFirstResponder()
            }
        }
        else if(currentTextFiled == txt3)
        {
            if(txt3.text!.count > 0 )
            {
                txt3.text = ""
            }
            else
            {
                currentTextFiled = txt2
                txt2.text = ""
                txt2.becomeFirstResponder()
            }
        }
        else if(currentTextFiled == txt4)
        {
            if(txt4.text!.count > 0 )
            {
                txt4.text = ""
            }
            else
            {
                currentTextFiled = txt3
                txt3.text = ""
                txt3.becomeFirstResponder()
            }
        }
        else if(currentTextFiled == txt5)
        {
            if(txt5.text!.count > 0 )
            {
                txt5.text = ""
            }
            else
            {
                currentTextFiled = txt4
                txt4.text = ""
                txt4.becomeFirstResponder()
            }
        }
        else if(currentTextFiled == txt6)
        {
            if(txt6.text!.count > 0 )
            {
                txt6.text = ""
            }
            else
            {
                currentTextFiled = txt5
                txt5.text = ""
                txt5.becomeFirstResponder()
            }
        }
    }
    @objc func myTargetFunction(textField: UITextField) {
        if(textField == txt1)
        {
            currentTextFiled = txt1
            txt1.text = ""
        }
        else if(textField == txt2)
        {
            currentTextFiled = txt2
            txt2.text = ""
        }
        else if(textField == txt3)
        {
            currentTextFiled = txt3
            txt3.text = ""
        }
        else if(textField == txt4)
        {
            currentTextFiled = txt4
            txt4.text = ""
        }
        else if(textField == txt5)
        {
            currentTextFiled = txt5
            txt5.text = ""
        }
        else if(textField == txt6)
        {
            currentTextFiled = txt6
            txt6.text = ""
        }
    }
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if text?.count == 1 {
            switch textField{
            case txt1:
                currentTextFiled = txt2
                txt2.text = ""
                txt2.becomeFirstResponder()
            case txt2:
                currentTextFiled = txt3
                txt3.text = ""
                txt3.becomeFirstResponder()
            case txt3:
                currentTextFiled = txt4
                txt4.text = ""
                txt4.becomeFirstResponder()
            case txt4:
                currentTextFiled = txt5
                txt5.text = ""
                txt5.becomeFirstResponder()
            case txt5:
                currentTextFiled = txt6
                txt6.text = ""
                txt6.becomeFirstResponder()
            case txt6:
                self.view.endEditing(true)
            default:
                break
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextFiled = textField as? MyTextField
        textField.text = ""
    }
    
    //MARK:- TextField Delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField)
        return true
    
    }
}
protocol MyTextFieldDelegate {
    func textFieldDidDelete()
}

class MyTextField: UITextField {
    var myDelegate: MyTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }
}
