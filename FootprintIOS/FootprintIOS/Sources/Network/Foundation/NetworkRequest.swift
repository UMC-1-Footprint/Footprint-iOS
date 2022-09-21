//
//  NetworkRequest.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct NetworkRequest {
    let url: String
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [String:String]?
    
    init(url: String,
         httpMethod: HTTPMethod,
         body: Data? = nil,
         headers: [String: String]? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = body
        self.headers = headers
    }
    
    func createNetworkRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}
