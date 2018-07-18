//
//  Location.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 14..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct MountainLocation: Codable, ModelTransformable {
    var code: String
    var latitude: String
    var longitude: String
}
