//
//  UserInfoLabel.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/19.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class UserInfoLabel: UILabel {
    
    // MARK: - Initiailizer
    
    init(title: String) {
        super.init(frame: .zero)
        
        text = title
        textColor = FootprintIOSAsset.Colors.blackD.color
        font = .systemFont(ofSize: 14, weight: .semibold)
        color(string: "*", color: FootprintIOSAsset.Colors.blueM.color)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
