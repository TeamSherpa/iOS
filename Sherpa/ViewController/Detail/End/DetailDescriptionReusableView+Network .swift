//
//  DetailDescriptionReusableView+Network .swift
//  Sherpa
//
//  Created by 신동규 on 2018. 7. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

extension DetailDescriptionReusableView{
    
    
    func requestHourlyWeather(city:String,county:String, village: String ,completion: @escaping (WeatherMeta?) -> Void) {
        
        let parameters = ["city":city,"county":county,"village":village]
        
        let router = APIRouter(url:"/getHourlyWeather", method: .get, parameters: parameters)
        NetworkRequestor(with: router).request { (mountains: WeatherMeta?, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(mountains)
        }
    }
}
