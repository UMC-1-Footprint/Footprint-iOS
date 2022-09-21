//
//  APIError.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

enum APIError: Error {
    case urlEncodingError
    case clientError(error: String)
    case serverError(error: String)
}
