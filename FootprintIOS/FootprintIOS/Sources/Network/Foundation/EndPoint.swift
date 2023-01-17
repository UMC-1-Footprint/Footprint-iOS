//
//  EndPoint.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol EndPoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    
    func createRequest() -> NetworkRequest
}

extension EndPoint {
    var headers: [String: String] {
        var headers: [String: String] = [:]
        headers["X-ACCESS-TOKEN"] = Provider.shared.Keychain.getJWTId()
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    func createRequest() -> NetworkRequest {
        return NetworkRequest(url: url,
                              httpMethod: method,
                              body: body,
                              headers: headers)
    }
}
