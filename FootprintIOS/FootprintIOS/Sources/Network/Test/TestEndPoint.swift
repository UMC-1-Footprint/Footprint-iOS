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
    
    func getURL(environment: APIEnvironment) -> String {
        switch self {
        case .testAPI:
            return "\(environment.baseURL)"
        }
    }
}
