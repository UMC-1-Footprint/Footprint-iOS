//
//  Collection+.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/10.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
