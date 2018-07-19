//
//  File.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 7. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
struct MountainSearchMeta: Codable {
	let code : String?
	let name : String?
	let height : Int?
	let address : String?
	let management : String?
	let detail : String?
	let summary : String?
	let imageURL : String?
	let isFamous : Int?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case name = "name"
		case height = "height"
		case address = "address"
		case management = "management"
		case detail = "detail"
		case summary = "summary"
		case imageURL = "imageURL"
		case isFamous = "isFamous"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		management = try values.decodeIfPresent(String.self, forKey: .management)
		detail = try values.decodeIfPresent(String.self, forKey: .detail)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
		isFamous = try values.decodeIfPresent(Int.self, forKey: .isFamous)
	}

}
