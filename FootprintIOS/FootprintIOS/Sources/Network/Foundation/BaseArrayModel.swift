//
//  BaseArrayModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/25.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct BaseArrayModel<T: Decodable>: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [T]
}
