//
//  WalkRecordDetailResponseDTO.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/30.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct WalkRecordDetailResponseDTO: Codable {
    let userDateWalk: UserDateWalk
    let hashtag: [String]
}

// MARK: - UserDateWalk
struct UserDateWalk: Codable {
    let walkIdx: Int
    let startTime, endTime: String
    let pathImageURL: String

    enum CodingKeys: String, CodingKey {
        case walkIdx, startTime, endTime
        case pathImageURL = "pathImageUrl"
    }
}
