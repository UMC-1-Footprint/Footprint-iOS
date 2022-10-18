//
//  FootprintButton.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum FootprintButtonType {
    case next
    case start
    case confirm
    case complete
    case startWalk
    
    var title: String {
        switch self {
        case .next:
            return "다음"
        case .start:
            return "시작하기"
        case .confirm:
            return "확인"
        case .complete:
            return "완료"
        case .startWalk:
            return "산책 시작하기"
        }
    }
}

class FootprintButton: UIButton {
    
    // MARK: - Properties
    
    let type: FootprintButtonType
    
    init(type: FootprintButtonType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setTitle(type.title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        backgroundColor = FootprintIOSAsset.Colors.blueM.color
        cornerRound(radius: 16)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
