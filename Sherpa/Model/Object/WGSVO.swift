//
//  WGSVO.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import ObjectMapper

class WGSVO: Mappable {
    
    var id : String?
    var result : Result?
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

class Result: Mappable {
    
    var posX: Float64?
    var posY: Float64?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        posX <- map["posX"]
        posY <- map["posY"]
    }
}




