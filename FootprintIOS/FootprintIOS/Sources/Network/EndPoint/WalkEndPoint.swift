//
//  WalkEndPoint.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum WalkEndPoint {
    case login(userId: String, userName: String, userEmail: String, providerType: ProviderType)
}

extension WalkEndPoint: EndPoint {
    var url: String {
        switch self {
        case .login:
            return Provider.shared.Enviroment.url + "/users/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .POST
        }
    }
    
    var body: Data? {
        return nil
    }
}
