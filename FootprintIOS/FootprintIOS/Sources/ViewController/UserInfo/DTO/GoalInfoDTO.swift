//
//  GoalInfoDTO.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct GoalInfoDTO {
    let dayIdx: [Int]
    let walkGoalTime, walkTimeSlot: Int
    
    func toDomain() -> GoalModel {
        GoalModel(dayIdx: dayIdx,
                  walkGoalTime: GoalTexts.goalWalkTexts[walkGoalTime],
                  walkTimeSlot: GoalTexts.walkTexts[walkTimeSlot])
    }
}
