//
//  InfoEndPoint.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/13.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

enum InfoEndPoint {
    case requestUserInfo(userInfo: InfoRequestDTO)
}

extension InfoEndPoint: EndPoint {
    var url: String {
        switch self {
        case .requestUserInfo:
            return Provider.shared.Enviroment.url + "/users/infos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestUserInfo:
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case let .requestUserInfo(userInfo):
            guard let body = try? JSONEncoder().encode(userInfo) else { return nil }
            
            return body
        }
    }
}
