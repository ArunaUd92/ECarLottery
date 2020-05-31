//
//  ECarLottery.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import Foundation
import ObjectMapper

struct ECarLottery : Mappable {
    var id : Int?
    var name : String?
    var description : String?
    var price : String?
    var currency : String?
    var type : String?
    var days : Int?
    var ticket_pp : Int?
    var tickets_count : Int?
    var tickets_sold : Int?
    var country : String?
    var sold : Int?
    var remove : Int?
    var featured : Int?
    var created_at : String?
    var updated_at : String?
    var features : Features?
    var questions : [Questions]?
    var images : [Images]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        price <- map["price"]
        currency <- map["currency"]
        type <- map["type"]
        days <- map["days"]
        ticket_pp <- map["ticket_pp"]
        tickets_count <- map["tickets_count"]
        tickets_sold <- map["tickets_sold"]
        country <- map["country"]
        sold <- map["sold"]
        remove <- map["remove"]
        featured <- map["featured"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        features <- map["features"]
        questions <- map["questions"]
        images <- map["images"]
    }
    
}


struct Features : Mappable {
    var id : Int?
    var lotteries_id : Int?
    var make : String?
    var model : String?
    var year : String?
    var type : String?
    var engine_type : String?
    var transmission : String?
    var doors : String?
    var millage : String?
    var created_at : String?
    var updated_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        lotteries_id <- map["lotteries_id"]
        make <- map["make"]
        model <- map["model"]
        year <- map["year"]
        type <- map["type"]
        engine_type <- map["engine_type"]
        transmission <- map["transmission"]
        doors <- map["doors"]
        millage <- map["millage"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}

struct Images : Mappable {
    var id : Int?
    var lotteries_id : Int?
    var created_at : String?
    var updated_at : String?
    var images : [VehicleImages]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        lotteries_id <- map["lotteries_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        images <- map["images"]
    }

}

struct VehicleImages : Mappable {
    var images : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        images <- map["images"]
    }

}

struct Questions : Mappable {
    var id : Int?
    var lotteries_id : Int?
    var question : String?
    var answer_correct : String?
    var created_at : String?
    var updated_at : String?
    var answer : [Answer]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        lotteries_id <- map["lotteries_id"]
        question <- map["question"]
        answer_correct <- map["answer_correct"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        answer <- map["answer"]
    }
    
}

struct Answer : Mappable {
    var key : Int?
    var answer : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        key <- map["key"]
        answer <- map["answer"]
    }
    
}

struct LottoryHome : Mappable {
    var current_page : Int?
    var total : Int?
    var data : [ECarLottery]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        current_page <- map["current_page"]
        total <- map["total"]
        data <- map["data"]
    }
}

