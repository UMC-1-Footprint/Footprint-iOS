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
    
    func getURL() -> String
    func createRequest() -> NetworkRequest
}

extension EndPoint {
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["X-ACCESS-TOKEN"] = Provider.shared.Keychain.getAccessToken()
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(),
                              httpMethod: method,
                              body: body,
                              headers: headers)
    }
}
