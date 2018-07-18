//
//  Local.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 18..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

struct Local: Codable, ModelTransformable {
    var title: String
    var link: String
    var description: String
    var telephone: String
}
