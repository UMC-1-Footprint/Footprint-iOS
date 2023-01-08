//
//  String+Ext.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

extension String {
    /// string 사이즈 얻는 함수
    /// - Parameters:
    ///   - font: 적용된 폰트
    func getSize(font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
