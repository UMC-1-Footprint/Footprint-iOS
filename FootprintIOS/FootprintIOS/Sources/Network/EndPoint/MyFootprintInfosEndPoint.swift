//
//  InfosEndPoint.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

enum MyFootprintInfosEndPoint {
    case get
}

extension MyFootprintInfosEndPoint: EndPoint {
    var url: String {
        switch self {
        case .get:
            return Provider.shared.Enviroment.url + "/users/infos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .get:
            return nil
        }
    }
}
