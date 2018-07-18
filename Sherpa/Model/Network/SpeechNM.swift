//
//  SpeechNM.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 16..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum SpeechError: Error {
    case emptyCategory
}

class SpeechNM {
    
    func sendSpeech(string: String, completion: @escaping (Category?, [ModelTransformable]?, Error?) -> Void) {
        
        let apiRouter = APIRouter(url: "/sendVoice", method: .get, parameters: ["input": string])
        NetworkRequestor(with: apiRouter).requestJSON { json, error in
            guard error == nil else {
                completion(nil, nil, error)
                return
            }
            guard let category = Category.allValues.first(where: { category in
                category.value == (json?["meta"]["Category"].stringValue ?? "")
            }) else {
                completion(nil, nil, SpeechError.emptyCategory)
                return
            }

            let jsonString = json?["meta"]["response"].description
            let jsonData = jsonString?.data(using: .utf8) ?? Data()
            do {
                switch category {
                case .education:
                    let result = try JSONDecoder().decode([Education].self, from: jsonData)
                    completion(.education, result, nil)
                case .mountain:
                    let result = try JSONDecoder().decode([Mountain].self, from: jsonData)
                    completion(.mountain, result, nil)
                case .news:
                    let result = try JSONDecoder().decode([Article].self, from: jsonData)
                    completion(.news, result, nil)
                case .trail:
                    break
                case .weather:
                    break
                case .traffic:
                    let result = try JSONDecoder().decode([MountainLocation].self, from: jsonData)
                    completion(.traffic, result, nil)
                case .local:
                    let result = try JSONDecoder().decode([Local].self, from: jsonData)
                    completion(.local, result, nil)
                default:
                    break
                }
            } catch let error {
                print(error)
                completion(nil, nil, error)
            }
        }
    }
}
