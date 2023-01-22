//
//  InfosResponseDTO.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

// MARK: - InfosResponseDTO
struct MyFootprintInfosResponseDTO: Codable {
    let getUserGoalRes: GetUserGoalRes
    let userInfoAchieve: UserInfoAchieve
    let userInfoStat: UserInfoStat
}

// MARK: - GetUserGoalRes
struct GetUserGoalRes: Codable {
    let dayIdx: [Int]
    let goalNextModified: Bool
    let month: String
    let userGoalTime: UserGoalTime
}

// MARK: - UserGoalTime
struct UserGoalTime: Codable {
    let walkGoalTime, walkTimeSlot: Int
}

// MARK: - UserInfoAchieve
struct UserInfoAchieve: Codable {
    let monthGoalRate, todayGoalRate, userWalkCount: Int
}

// MARK: - UserInfoStat
struct UserInfoStat: Codable {
    let monthlyGoalRate, monthlyWalkCount: [Int]
    let mostWalkDay: [String]
    let thisMonthGoalRate, thisMonthWalkCount: Int
    let userWeekDayRate: [Int]
}
