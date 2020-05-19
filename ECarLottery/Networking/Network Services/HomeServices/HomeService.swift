//
//  HomeServices.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HomeService: BaseService {
    
    func getECarLotteryList(onSuccess: @escaping ([ECarLottery]) -> Void, onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {
        
        Alamofire.request(Router.getECarLotteryList)
            .validate()
            .responseObject { (response: DataResponse<ListResponse<ECarLottery>>) in
                
                switch response.result {
                case .success(let value):
                    
                    if (value.result == true) {
                        onSuccess(value.data!)
                        
                    } else {
                        onResponseError(value.message!, value.result!)
                    }
                    
                case .failure(let error):
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                    
                }
        }
    }
}
