//
//  APIRouter.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Alamofire

struct APIConfiguration {
    static let baseURL = "http://52.78.104.4:8080"
    static let tmapKey = "0a6a4a4c-e1ce-4016-9795-5608455ad7b3"
}

struct APIRouter {
    var url: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

extension APIRouter {
    var requestUrl: String {
        return APIConfiguration.baseURL + url
    }
}
