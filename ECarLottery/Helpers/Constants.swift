//
//  Constants.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation

struct Constants {
    
    static let COUNTRYCODE = "+94"
    
    static let APPKEY = "5695451dd88713676f0b84a430e648eads"
    
    struct Security {
        static let access_token_key = "access_token"
        static let refresh_token_key = "refresh_token"
        static let id_token_key = "id_token"
    }
    
    struct HttpResponseCode {
        
        static let ResponseSuccess = 200
        static let ErrorBadRequest = 400
        static let ErrorUnauthorized = 401
        static let ErrorForbidden = 403
        static let ErrorNotFound = 404
        static let ErrorInternalServer = 500
        static let ErrorValidation = 1000
    }
    
    
}
