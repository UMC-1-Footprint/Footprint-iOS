//
//  InfoEndPoint.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/13.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

enum InfoEndPoint {
    case postUserInfo(userInfo: InfoRequestDTO)
    case getThisMonth
    case getNextMonth
    case patchNextMonthGoal(goalInfo: GoalRequestDTO)
}

extension InfoEndPoint: EndPoint {
    var url: String {
        switch self {
        case .postUserInfo:
            return Provider.shared.Enviroment.url + "/users/infos"
        case .getThisMonth, .patchNextMonthGoal:
            return Provider.shared.Enviroment.url + "/users/goals"
        case .getNextMonth:
            return Provider.shared.Enviroment.url + "/users/goals/next"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postUserInfo:
            return .POST
        case .getNextMonth, .getThisMonth:
            return .GET
        case .patchNextMonthGoal:
            return .PATCH
        }
    }
    
    var body: Data? {
        switch self {
        case let .postUserInfo(userInfo):
            guard let body = try? JSONEncoder().encode(userInfo) else { return nil }
            
            return body
        case let .patchNextMonthGoal(goalInfo):
            guard let body = try? JSONEncoder().encode(goalInfo) else { return nil }
            
            return body
        default:
            return nil
        }
    }
}
