//
//  LoginEndPoint.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum LoginEndPoint {
    case login(userId: String, userName: String, userEmail: String, providerType: LoginProviderType)
}

extension LoginEndPoint: EndPoint {
    func getURL() -> String {
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
        switch self {
        case let .login(userId, userName, userEmail, providerType):
            let parameters = LoginRequestDTO(userID: userId, username: userName, email: userEmail, providerType: providerType)
            guard let body = try? JSONEncoder().encode(parameters) else { return nil }
                
            return body
        }
    }
}
