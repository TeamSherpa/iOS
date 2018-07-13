//
//  NetworkRequestor.swift
//  Sherpa
//
//  Created by Minseob Yoon on 2018. 6. 17..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case failure
}

struct NetworkRequestor {
    
    private var api: APIRouter
    private let manager = Alamofire.SessionManager.default
    public typealias Completion<T> = ((T?, Error?) -> Void)?
    public typealias CompletionJSON = ((JSON?, Error?) -> Void)?
    
    init(with router: APIRouter) {
        self.api = router
        manager.session.configuration.timeoutIntervalForRequest = 15
    }
    
    func request<T: Codable>(completion: Completion<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, headers: api.headers).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    guard JSON(data)["result"].intValue == 200 else {
                        completion?(nil, NetworkError.failure)
                        return
                    }
                    let jsonString = JSON(data)["meta"].description
                    let jsonData = jsonString.data(using: .utf8) ?? Data()
                    do {
                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        completion?(result, nil)
                    } catch let error {
                        completion?(nil, error)
                    }
                }
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func requestJSON(completion: CompletionJSON) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, headers: api.headers).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    let parsedData = JSON(data)
                    guard JSON(data)["result"].intValue == 200 else {
                        completion?(nil, NetworkError.failure)
                        return
                    }
                    completion?(parsedData, nil)
                }
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
