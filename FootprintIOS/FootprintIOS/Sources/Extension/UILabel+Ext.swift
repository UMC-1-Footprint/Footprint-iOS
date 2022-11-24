//
//  UILabel+Ext.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/19.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

extension UILabel {
    /// label 특정 색 적용 함수
    /// - Parameters:
    ///   - string: 색상 변경하고 싶은 문자열
    ///   - color: UIColor 색상
    func color(string: String, color: UIColor) {
        let text = text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: string)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
