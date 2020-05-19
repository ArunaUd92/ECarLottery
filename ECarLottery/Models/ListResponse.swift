//
//  ListResponse.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import ObjectMapper

struct ListResponse<T: Mappable>: Mappable {
    var result: Bool?
    var status_code: Int?
    var status_message: String?
    var message: String?
    var data: [T]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        result <- map["result"]
        status_code <- map["status_code"]
        status_message <- map["status_message"]
        message <- map["message"]
        data <- map["data"]
    }
}
