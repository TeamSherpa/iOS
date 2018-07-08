//
//  g.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON

class GetWGSNM : NetworkDelegate {
    
    func getwgs(x: String, y: String, token: String, index: Int) {
        
        let URL = "https://sgisapi.kostat.go.kr/OpenAPI3/transformation/transcoord.json?accessToken=\(token)&src=5186&dst=4326&posY=\(y)&posX=\(x)"
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default, headers:nil).responseObject{ [weak self]
            (response: DataResponse<WGSVO>) in
            switch response.result{
            case .success:
                guard let value = response.result.value else {
                    self?.delegate.networkFailed(msg: "")
                    return
                }
                if let resultdoc  = value.result {
                    self?.delegate.networkResultData(resultData: (index, resultdoc), code: "success getWGS")
                }
            case .failure:
                self?.delegate.networkFailed(msg: "")
            }
        }
    }
    
}
