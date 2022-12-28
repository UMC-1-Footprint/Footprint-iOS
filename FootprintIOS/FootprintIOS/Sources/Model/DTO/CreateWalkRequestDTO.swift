//
//  CreateWalkRequestDTO.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct CreateWalkRequestDTO: Codable {
    let walk: Walk
    let footprintList: [FootprintList]
}

// MARK: - FootprintList
struct FootprintList: Codable {
    let coordinates: [Double]
    let recordAt, write: String
    let hashtagList: [String]
    let onWalk: Int
    let photos: [String]
}
