//
//  Router.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://app.ecarlottery.com/api"
    
    case getECarLotteryList(String,String,String,Int)
    case postInquiry(parameters: Parameters)

    var method: HTTPMethod {
        switch self {
        case .getECarLotteryList:
            return .get
        case .postInquiry:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getECarLotteryList:
            return "/lottory-home"
        case .postInquiry:
            return "/api-inquiry"
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .getECarLotteryList(price_range,item,newest,per_page):
                return ("/lottory-home", ["price_range": price_range, "item": item, "newest": newest, "page": per_page])
            default:
                return ("", [:])
            }
        }()
        
        let url = try Router.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
//        if let userDefaults = UserDefaults(suiteName: "group.com.gamata"),
//            let token = userDefaults.string(forKey: Constants.Security.id_token_key) {
//            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        }
        
        urlRequest.addValue(Constants.APPKEY, forHTTPHeaderField: "App-Key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .getECarLotteryList:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: result.parameters)
        case .postInquiry(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

