//
//  EndPoint.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol EndPoint {
    var method: HTTPMethod { get }
    var body: Data? { get }
    
    func createRequest() -> NetworkRequest
}

extension EndPoint {
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["X-ACCESS-TOKEN"] = KeychainHandler.shared.accessToken
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: Enviroment.apiBaseURL,
                              httpMethod: method,
                              body: body,
                              headers: headers)
    }
}
