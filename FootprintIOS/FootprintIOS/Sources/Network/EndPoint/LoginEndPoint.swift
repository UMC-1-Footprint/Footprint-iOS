//
//  LoginEndPoint.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum ProviderTypeT: String {
    case kakao = "kakao"
    case google = "google"
    case apple = "apple"
}

enum LoginEndPoint {
    case login(userId: String, userName: String, userEmail: String, providerType: ProviderType)
}

extension LoginEndPoint: EndPoint {
    func getURL() -> String {
        switch self {
        case .login:
            return Environment.apiBaseURL + "/users/auth/login"
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
