//
//  RecommendMountainList.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 7. 8..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

typealias RecommendInfo = (name: String, city: String, county: String, country: String, date: String)
struct RecommendMountains {
    
    static let lists: [RecommendInfo] = [
        ("도봉산", "서울", "도봉구", "도봉동", "0708"),
        ("관악산", "서울", "관악구", "신림동", "0709"),
        ("구룡산", "서울", "서초구", "내곡동", "0710"),
        ("대모산", "서울", "강남구", "일원본동", "0711"),
        ("도봉산", "서울", "도봉구", "도봉동", "0712"),
        ("북악산", "서울", "종로구", "부암동", "0713"),
        ("아차산", "서울", "광진구", "중곡동", "0714"),
        ("인왕산", "서울", "서대문구", "홍제동", "0715"),
        ("도봉산", "서울", "도봉구", "도봉동", "0716"),
        ("관악산", "서울", "관악구", "신림동", "0717"),
        ("구룡산", "서울", "서초구", "내곡동", "0718"),
        ("대모산", "서울", "강남구", "일원본동", "0719"),
        ("도봉산", "서울", "도봉구", "도봉동", "0720"),
        ("관악산", "서울", "관악구", "신림동", "0721"),
        ("북한산_백운대", "서울", "강북구", "수유동", "0722"),
        ("북한산_백운대", "서울", "강북구", "수유동", "0722"),
        ("계족산", "대전", "대덕구", "장동", "0801"),
        ("계족산", "대전", "대덕구", "장동", "0802")
    ]
    
    static func acquire() -> RecommendInfo? {
        let todayRecommendMountain = RecommendMountains.lists.first { _, _, _, _, date in
            return Date().dateString == date
        }
        return todayRecommendMountain
    }
}
