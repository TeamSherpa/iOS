//
//  NetworkCallBack.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 5. 22..
//  Copyright © 2018년 신동규. All rights reserved.
//

import Foundation

protocol NetworkCallBack{
    func networkResultData(resultData: Any, code: String)
    func networkFailed(msg: Any?)
}
