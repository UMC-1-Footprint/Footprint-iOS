//
//  LoginRequestModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

// MARK: - LoginRequestDTO
struct LoginRequestDTO: Codable {
    let userID, username, email: String
    let providerType: LoginProviderType

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case username, email, providerType
    }
}
