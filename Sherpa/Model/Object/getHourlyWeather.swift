//
//  File.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 30..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
struct getHourlyWeather: Codable, ModelTransformable {
	let result : Int?
	let meta : WeatherMeta?

	enum CodingKeys: String, CodingKey {

		case result = "result"
		case meta = "meta"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		result = try values.decodeIfPresent(Int.self, forKey: .result)
		meta = try values.decodeIfPresent(WeatherMeta.self, forKey: .meta)
	}

}

struct WeatherMeta : Codable {
    let windSpeed : String?
    let fallenForAnHour : String?
    let fallenType : String?
    let skyCode : String?
    let tempNow : String?
    let tempMax : String?
    let tempMin : String?
    let humidity : String?
    let lightningYn : String?
    let sunRiseTime : String?
    let sunSetTime : String?
    let uvIndex : String?
    let uvComment : String?
    let alertYn : String?
    let stormYn : String?
    let alertSummary : String?
    let alertMessage : String?
    let latitude : String?
    let longitude : String?
    
    enum CodingKeys: String, CodingKey {
        
        case windSpeed = "windSpeed"
        case fallenForAnHour = "fallenForAnHour"
        case fallenType = "fallenType"
        case skyCode = "skyCode"
        case tempNow = "tempNow"
        case tempMax = "tempMax"
        case tempMin = "tempMin"
        case humidity = "humidity"
        case lightningYn = "lightningYn"
        case sunRiseTime = "sunRiseTime"
        case sunSetTime = "sunSetTime"
        case uvIndex = "uvIndex"
        case uvComment = "uvComment"
        case alertYn = "alertYn"
        case stormYn = "stormYn"
        case alertSummary = "alertSummary"
        case alertMessage = "alertMessage"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        windSpeed = try values.decodeIfPresent(String.self, forKey: .windSpeed)
        fallenForAnHour = try values.decodeIfPresent(String.self, forKey: .fallenForAnHour)
        fallenType = try values.decodeIfPresent(String.self, forKey: .fallenType)
        skyCode = try values.decodeIfPresent(String.self, forKey: .skyCode)
        tempNow = try values.decodeIfPresent(String.self, forKey: .tempNow)
        tempMax = try values.decodeIfPresent(String.self, forKey: .tempMax)
        tempMin = try values.decodeIfPresent(String.self, forKey: .tempMin)
        humidity = try values.decodeIfPresent(String.self, forKey: .humidity)
        lightningYn = try values.decodeIfPresent(String.self, forKey: .lightningYn)
        sunRiseTime = try values.decodeIfPresent(String.self, forKey: .sunRiseTime)
        sunSetTime = try values.decodeIfPresent(String.self, forKey: .sunSetTime)
        uvIndex = try values.decodeIfPresent(String.self, forKey: .uvIndex)
        uvComment = try values.decodeIfPresent(String.self, forKey: .uvComment)
        alertYn = try values.decodeIfPresent(String.self, forKey: .alertYn)
        stormYn = try values.decodeIfPresent(String.self, forKey: .stormYn)
        alertSummary = try values.decodeIfPresent(String.self, forKey: .alertSummary)
        alertMessage = try values.decodeIfPresent(String.self, forKey: .alertMessage)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
    }
    
}
