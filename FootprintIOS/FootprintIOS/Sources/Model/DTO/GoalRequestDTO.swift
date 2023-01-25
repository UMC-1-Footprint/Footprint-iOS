//
//  GoalRequestDTO.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/23.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct GoalRequestDTO: Codable {
    let dayIdx: [Int]
    let walkGoalTime, walkTimeSlot: Int
}
