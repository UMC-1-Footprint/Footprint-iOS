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
    
    func getURL(environment: APIEnvironment) -> String
    func createRequest(environment: APIEnvironment) -> NetworkRequest
}

extension EndPoint {
    func createRequest(environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(environment: environment),
                              httpMethod: method,
                              body: body,
                              headers: headers)
    }
}
