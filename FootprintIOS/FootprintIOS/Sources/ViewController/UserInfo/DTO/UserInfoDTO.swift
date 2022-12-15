//
//  UserInfoDTO.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/21.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct UserInfoDTO: Codable {
    let nickname,sex,birth: String
    let height,weight: Int
    let dayIdx: [Int]
    let walkGoalTime, walkTimeSlot: Int
}
