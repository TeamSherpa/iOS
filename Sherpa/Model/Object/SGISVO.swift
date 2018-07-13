//
//  File.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 30..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import ObjectMapper

class SGISVO: Mappable {
    
    var id: String?
    var result: Access?
    var errMsg: String?
    var errCd: Int?
    var trId: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        result <- map["result"]
        errMsg <- map["errMsg"]
        errCd <- map["errCd"]
        trId <- map["trId"]
    }
}

class Access: Mappable {
    
    var accessTimeout: String?
    var accessToken: String?
    
    required init?(map: Map) { }
    
   func mapping(map: Map) {
        accessTimeout <- map["accessTimeout"]
        accessToken <- map["accessToken"]
    }
}
