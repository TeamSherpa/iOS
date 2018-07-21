//
//  Education.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct Education: Codable, ModelTransformable {
    var name: String?
    var address: String?
    var category: String?
    var period: String?
}

extension Education {
    
    enum CodingKeys: String, CodingKey {
        case name = "facnm"
        case address = "addr"
        case category = "category"
        case period = "period"
    }
}
