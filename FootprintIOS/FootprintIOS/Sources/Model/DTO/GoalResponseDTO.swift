//
//  GoalResponseDTO.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/23.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct GoalResponseDTO: Codable {
    let month: String
    let dayIdx: [Int]
    let userGoalTime: UserGoalTime
    let goalNextModified: Bool
    
    func toDomain() -> GoalModel {
        GoalModel(dayIdx: dayIdx,
                  walkGoalTime: InfoTexts.goalWalkNums[userGoalTime.walkGoalTime] ?? "0",
                  walkTimeSlot: InfoTexts.walkTexts[safe: userGoalTime.walkTimeSlot - 1] ?? "0")
    }
}

struct UserGoalTime: Codable {
    let walkGoalTime: Int
    let walkTimeSlot: Int
}
