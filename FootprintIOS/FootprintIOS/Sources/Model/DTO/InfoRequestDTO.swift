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
    var birth: String?
    var height,weight: Int?
    let dayIdx: [Int]
    let walkGoalTime, walkTimeSlot: Int
    
    enum CodingKeys: CodingKey {
        case nickname
        case sex
        case birth
        case height
        case weight
        case dayIdx
        case walkGoalTime
        case walkTimeSlot
    }
}

extension InfoRequestDTO {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(sex, forKey: .sex)
        try container.encode(dayIdx, forKey: .dayIdx)
        try container.encode(walkGoalTime, forKey: .walkGoalTime)
        try container.encode(walkTimeSlot, forKey: .walkTimeSlot)
        
        try container.encodeIfPresent(birth, forKey: .birth)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(weight, forKey: .weight)
    }
}
