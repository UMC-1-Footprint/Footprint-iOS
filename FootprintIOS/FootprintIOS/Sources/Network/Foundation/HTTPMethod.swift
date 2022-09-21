//
//  HTTPMethod.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

enum HTTPHeaderField {
    case authentication
    case contentType
    case acceptType
    
    var code: String {
        switch self {
        case .authentication:
            return "Autorization"
        case .contentType:
            return "Content-Type"
        case .acceptType:
            return "Accept"
        }
    }
}

enum ContentType {
    case json
    
    var code: String {
        switch self {
        case .json:
            return "application/json"
        }
    }
}
