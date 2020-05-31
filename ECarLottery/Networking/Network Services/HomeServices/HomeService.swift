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
    
    func getECarLotteryList(priceRange: String, itemType: String, sortBy: String, pageCount: Int, onSuccess: @escaping ([ECarLottery]) -> Void, onResponseError: @escaping (String, Bool) -> Void, onError: @escaping (String, Int) -> Void) {
        
        Alamofire.request(Router.getECarLotteryList(priceRange,itemType,sortBy,pageCount))
            .validate()
            .responseObject { (response: DataResponse<ListResponse<ECarLottery>>) in
                
                switch response.result {
                case .success(let value):
                    
                    if (value.result == true) {
                        let responseDataSet = value.data
                        onSuccess(responseDataSet!)
                        
                    } else {
                        onResponseError("", value.result!)
                    }
                    
                case .failure(let error):
                    onError(error.localizedDescription, ((response.response) != nil) ? (response.response?.statusCode)! : 500)
                    break
                    
                }
        }
    }
}
