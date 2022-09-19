//
//  APIEnvironment.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum APIEnvironment: String {
    case dev
    case production
    case test
}

extension APIEnvironment {
    var baseURL: String {
        switch self {
        case .dev:
            return "https://dev.mysteps.shop"
        case .production:
            return "https://prod.mysteps.shop"
        case .test:
            return "https://jsonplaceholder.typicode.com/users"
        }
    }
}
