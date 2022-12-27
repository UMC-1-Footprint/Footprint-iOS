//
//  WalkAPI.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum WalkAPI {
    case fetch
    case create
    case delete
}

extension WalkAPI: EndPoint {
    var method: HTTPMethod{
        switch self {
        case .fetch:
            return .GET
            
        case .create:
            return .POST
            
        case .delete:
            return .PATCH
        }
    }
    
    var body: Data? {
        switch self {
        case .fetch:
            return nil
            
        case .create:
            return nil
            
        case .delete:
            return nil
        }
    }
    
    func getURL(environment: APIEnvironment) -> String {
        switch self {
        case .fetch:
            return ""
            
        case .create:
            return ""
            
        case .delete:
            return ""
        }
    }
}
