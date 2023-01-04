//
//  Walk.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

struct Walk: Codable {
    let startAt, endAt: String
    let distance: Int
    let coordinates: [[Double]]
    let calorie: Int
    let thumbnail: String
}
