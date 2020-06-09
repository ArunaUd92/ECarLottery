//
//  AuthService.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 6/2/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AuthService: BaseService {
    
    // Login
    func postLogin(email: String, password: String, onSuccess: @escaping () -> Void,  onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {

        let parameters: Parameters = [
            "email": email,
            "password": password
        ]

        Alamofire.request(Router.postLogin(parameters: parameters))
            .validate()
            .responseObject { (response: DataResponse<SingleResponse<User>>) in

                switch response.result {
                case .success(let value):

                    if (value.result == true) {
                        onSuccess()

                    } else {
                        onResponseError(value.message!, false)
                    }

                case .failure(let error):
                    print(error)
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                }

        }
    }
    
    //Registration
    func postRegistration(firstName: String, lastName: String, email: String, password: String, onSuccess: @escaping () -> Void,  onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {

        let parameters: Parameters = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "password": password
        ]

        Alamofire.request(Router.postRegistration(parameters: parameters))
            .validate()
            .responseObject { (response: DataResponse<SingleResponse<User>>) in

                switch response.result {
                case .success(let value):

                    if (value.result == true) {
                        onSuccess()

                    } else {
                        onResponseError(value.message!, false)
                    }

                case .failure(let error):
                    print(error)
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                }

        }
    }
    
    // Verification
    func postOTPVerification(email: String, otpCode: String, onSuccess: @escaping () -> Void,  onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {

        let parameters: Parameters = [
            "email": email,
            "otp": otpCode
        ]

        Alamofire.request(Router.postOTPVerification(parameters: parameters))
            .validate()
            .responseObject { (response: DataResponse<SingleResponse<User>>) in

                switch response.result {
                case .success(let value):

                    if (value.result == true) {
                        onSuccess()

                    } else {
                        onResponseError(value.message!, false)
                    }

                case .failure(let error):
                    print(error)
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                }

        }
    }
    
    // Reset password
    func postResetPassword(email: String, onSuccess: @escaping () -> Void,  onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {

        let parameters: Parameters = [
            "email": email
        ]

        Alamofire.request(Router.postLogin(parameters: parameters))
            .validate()
            .responseObject { (response: DataResponse<SingleResponse<User>>) in

                switch response.result {
                case .success(let value):

                    if (value.result == true) {
                        onSuccess()

                    } else {
                        onResponseError(value.message!, false)
                    }

                case .failure(let error):
                    print(error)
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                }

        }
    }
}



