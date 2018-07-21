//
//  Traffic.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 7. 21..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
struct Traffic : Codable {
    let taxiFare : Int?
    let name : String?
    let pointType : String?
    let description : String?
    let arrivalTime : String?
    let index : Int?
    let nextRoadName : String?
    let totalDistance : Int?
    let departureTime : String?
    let turnType : Int?
    let pointIndex : Int?
    let totalTime : Int?
    let totalFare : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case taxiFare = "taxiFare"
        case name = "name"
        case pointType = "pointType"
        case description = "description"
        case arrivalTime = "arrivalTime"
        case index = "index"
        case nextRoadName = "nextRoadName"
        case totalDistance = "totalDistance"
        case departureTime = "departureTime"
        case turnType = "turnType"
        case pointIndex = "pointIndex"
        case totalTime = "totalTime"
        case totalFare = "totalFare"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taxiFare = try values.decodeIfPresent(Int.self, forKey: .taxiFare)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pointType = try values.decodeIfPresent(String.self, forKey: .pointType)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime)
        index = try values.decodeIfPresent(Int.self, forKey: .index)
        nextRoadName = try values.decodeIfPresent(String.self, forKey: .nextRoadName)
        totalDistance = try values.decodeIfPresent(Int.self, forKey: .totalDistance)
        departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)
        turnType = try values.decodeIfPresent(Int.self, forKey: .turnType)
        pointIndex = try values.decodeIfPresent(Int.self, forKey: .pointIndex)
        totalTime = try values.decodeIfPresent(Int.self, forKey: .totalTime)
        totalFare = try values.decodeIfPresent(Int.self, forKey: .totalFare)
    }
    
}
