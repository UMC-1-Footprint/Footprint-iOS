//
//  InfoTextField.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/19.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum InfoTextFieldType {
    case nickname
    case height
    case weight
    
    var placeholder: String {
        switch self {
        case .nickname:
            return "닉네임을 입력해 주세요 (최대 8자)"
        case .height:
            return "키 입력"
        case .weight:
            return "몸무게 입력"
        }
    }
}

class InfoTextField: UITextField {
    
    // MARK: - Properties
    
    let type: InfoTextFieldType
    
    // MARK: - Initializer
    
    init(type: InfoTextFieldType) {
        self.type = type
        
        super.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(string: type.placeholder, attributes: [NSAttributedString.Key.foregroundColor: FootprintIOSAsset.Colors.whiteD.color])
        makeBorder(color: FootprintIOSAsset.Colors.whiteD.color, width: 1)
        layer.cornerRadius = 12
        addLeftPadding()
        
        switch type {
        case .nickname:
            textAlignment = .natural
            keyboardType = .default
            leftViewMode = ViewMode.always
        case .height, .weight:
            textAlignment = .center
            keyboardType = .numberPad
            leftViewMode = ViewMode.never
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = paddingView
    }
}
