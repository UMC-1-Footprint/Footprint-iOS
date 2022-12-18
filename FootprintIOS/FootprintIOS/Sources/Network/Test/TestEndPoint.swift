//
//  TestEndPoint.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum TestEndPoint {
    case testAPI
}

extension TestEndPoint: EndPoint {
    
    var method: HTTPMethod{
        switch self {
        case .testAPI:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .testAPI:
            return nil
        }
    }
    
    func getURL() -> String {
        let apiEnvironment = APIEnvironment.test
        return apiEnvironment.baseURL
    }
    
    func getURL(environment: APIEnvironment) -> String {
        switch self {
        case .testAPI:
            return "\(environment.baseURL)"
        }
    }
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(),
                              httpMethod: method,
                              body: body,
                              headers: headers)
    }
}
