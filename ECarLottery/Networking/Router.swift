//
//  Router.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://propertyhuntergroup.com/mobapp"
    
    case getECarLotteryList
    case getPropertyListNew(String,String,String,String,String,String,String,String,String)
    case postInquiry(parameters: Parameters)

    var method: HTTPMethod {
        switch self {
        case .getPropertyListNew, .getECarLotteryList:
            return .get
        case .postInquiry:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getPropertyListNew:
            return "/api-properties"
        case .getECarLotteryList:
            return "/a"
        case .postInquiry:
            return "/api-inquiry"
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .getPropertyListNew (cat_type,sub_cat_type,budget,area,beadroom,location,sort,per_page, recentSold):
                    return ("/api-properties", ["cat_type": cat_type, "sub_cat_type": sub_cat_type, "budget": budget, "area": area, "beadroom": beadroom, "location": location, "sort": sort, "per_page": per_page, "recent_sold": recentSold])
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
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .getECarLotteryList, .getPropertyListNew:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: result.parameters)
        case .postInquiry(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

