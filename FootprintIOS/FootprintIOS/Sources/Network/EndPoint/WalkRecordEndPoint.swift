//
//  WalkRecordEndPoint.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/10.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

enum WalkRecordEndPoint {
    case getNumber(year: Int, month: Int)
    case getDetail(userIdx: String, date: String)
}

extension WalkRecordEndPoint: EndPoint {
    var url: String {
        switch self {
        case let .getNumber(year, month):
            var urlComponents = URLComponents(string: Provider.shared.Enviroment.url + "/users/months/footprints?")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "year", value: String(year)),
                URLQueryItem(name: "month", value: String(month))
            ]
            
            guard let url = urlComponents?.url else { return .init() }
            return url.absoluteString
        case let .getDetail(userIdx, date):
            var urlComponents = URLComponents(string: Provider.shared.Enviroment.url + "/users/\(userIdx)?")
            
            urlComponents?.queryItems = [
                URLQueryItem(name: "date", value: String(date))
            ]
            
            guard let url = urlComponents?.url else { return .init() }
            return url.absoluteString
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNumber, .getDetail:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getDetail, .getNumber:
            return nil
        }
    }
}
