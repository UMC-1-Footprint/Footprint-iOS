//
//  LoginResponseModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let jwtID: String
    let status: String
    let checkMonthChanged: Bool

    enum CodingKeys: String, CodingKey {
        case jwtID = "jwtId"
        case status, checkMonthChanged
    }
}
