//
//  BaseModel.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: T?
}
