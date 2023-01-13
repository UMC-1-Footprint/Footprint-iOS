//
//  DefaultResponse.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/13.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

struct DefaultResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    //let result: String
}
