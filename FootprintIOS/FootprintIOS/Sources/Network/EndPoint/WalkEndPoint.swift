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
    func getURL() -> String {
        switch self {
        case .login:
            return Environment.url + "/users/auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case let .login(userId, userName, userEmail, providerType):
            let parameters = LoginRequestModel(userID: userId, username: userName, email: userEmail, providerType: providerType.rawValue)
            guard let body = try? JSONEncoder().encode(parameters) else { return nil }
                
            return body
        }
    }
}
