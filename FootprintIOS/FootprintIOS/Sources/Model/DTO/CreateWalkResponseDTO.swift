//
//  CreateWalkResponseDTO.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct CreateWalkResponseDTO: Codable {
    let badgeIdx: Int
    let badgeName: String
    let badgeUrl: String
}
