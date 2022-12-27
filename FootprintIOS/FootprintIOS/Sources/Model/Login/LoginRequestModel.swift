//
//  LoginRequestModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

// MARK: - LoginRequestDTO
struct LoginRequestModel: Codable {
    let userID, username, email, providerType: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case username, email, providerType
    }
}
