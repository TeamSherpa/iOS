//
//  File.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 7. 16 ..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
struct  MountainSearch: Codable {
	let result : Int?
	let meta : MountainSearchMeta?

	enum CodingKeys: String, CodingKey {

		case result = "result"
		case meta = "meta"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		result = try values.decodeIfPresent(Int.self, forKey: .result)
		meta = try values.decodeIfPresent(MountainSearchMeta.self, forKey: .meta)
	}

}
