//
//  ELMessageView.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

class ELMessageView {
    // Message View Title
    static let MESSAGE_TITLE_SUCCESS: String = "Success"
    static let MESSAGE_TITLE_ERROR: String = "Error"
    
    // Message View Subtitle
    static let MESSAGE_SUBTITLE_PAYMENT_SUCCESS: String = "Your payment has been processed successfully."
    static let MESSAGE_SUBTITLE_INFORMATION_UPDATE_SUCCESS: String = "Your Informations has been updated successfully."
    static let MESSAGE_SUBTITLE_ACCOUNT_CREATE_SUCCESS: String = "Your account has been created successfully."
    static let MESSAGE_SUBTITLE_PASSWORD_UPDATE_SUCCESS: String = "Your New Password has been updated successfully."
    
    // Error Message
    static let ERROR_MESSAGE_RESPONSE_ERROR: String = "Something went wrong. Please try again later."
    
    // Message Type
    static let ErrorMessage = 1
    static let InfoMessage = 2
    static let WarningMessage = 3
    static let SuccessMessage = 4

    // Show Message - validation & Errors
    static func showMessage(type: Int, title: String, message: String) {
        if !message.isEmpty {
            let error = MessageView.viewFromNib(layout: .messageView)
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            
            switch type {
            case ErrorMessage:
                error.configureTheme(.error)
                error.configureTheme(backgroundColor: UIColor.init(hexString: Config.COLOR_APP_BACKGROUND_RED, alpha: 1), foregroundColor: UIColor.white, iconImage: UIImage(named:"la_warning.png"), iconText: nil)
                error.titleLabel?.isHidden = true
                
            case InfoMessage:
                error.configureTheme(.info)
                
            case WarningMessage:
                error.configureTheme(.warning)
                
            case SuccessMessage:
                error.configureTheme(.success)
                
            default:
                error.configureTheme(.info)
            }
            
            error.configureContent(title: "", body: message)
            error.button?.setTitle("Stop", for: .normal)
            error.button?.isHidden = true
            
            SwiftMessages.show(config: config, view: error)
        }
    }
    
    // Show api response error message for code
    static func showResponseErrorMessage(code: Int) {
        
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.error)
        
        switch code {
        case Constants.HttpResponseCode.ErrorBadRequest:
            error.configureContent(title: "Error", body: "Bad Request: Something went wrong with your request, most likely a missing argument or parameter.")
            
        case Constants.HttpResponseCode.ErrorUnauthorized:
            error.configureContent(title: "Error", body: "Authentication was incorrect.")
            
        case Constants.HttpResponseCode.ErrorForbidden:
            error.configureContent(title: "Error", body: "You don’t have the necessary permissions for the resource.")
            
        case Constants.HttpResponseCode.ErrorNotFound:
            error.configureContent(title: "Error", body: "Something went wrong, Please try again later.")
            
        case Constants.HttpResponseCode.ErrorInternalServer:
            error.configureContent(title: "Error", body: "Something went wrong, Please try again later.")
            
        case Constants.HttpResponseCode.ErrorValidation:
            error.configureContent(title: "Error", body: "Validation Error")
            
        default:
            error.configureContent(title: "Error", body: "Something went wrong, Please try again later.")
            
        }
        
        error.button?.setTitle("Stop", for: .normal)
        error.button?.isHidden = true
        SwiftMessages.show(view: error)
        
    }
    
}
