//
//  InfoRequestDTO.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/13.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct InfoRequestDTO: Codable {
    let nickname,sex: String
    let birth: String?
    let height,weight: Int?
    let dayIdx: [Int]
    let walkGoalTime, walkTimeSlot: Int
}
