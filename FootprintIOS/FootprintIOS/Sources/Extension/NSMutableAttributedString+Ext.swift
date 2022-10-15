//
//  NSMutableAttributedString+Ext.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/10/11.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
