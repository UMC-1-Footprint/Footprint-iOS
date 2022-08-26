//
//  OnboardingView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum OnboardingViewType {
    case one
    case two
    case three
    case four
    
    var index: Int {
        switch self {
        case .one:
            return 0
        case .two:
            return 1
        case .three:
            return 2
        case .four:
            return 3
        }
    }
    
    var title: String {
        switch self {
        case .one:
            return "반가워요! 👋"
        case .two:
            return "산책 목표 설정하기"
        case .three:
            return "산책 기록하기"
        case .four:
            return "산책 일기 확인하기"
        }
    }
    
    var subTitle: String {
        switch self {
        case .one:
            return "산책하러 오셨군요! 발자국에 오신걸 환영합니다"
        case .two:
            return "산책할 요일과 목표 산책 시간을 선택해\n나만의 산책 목표를 세워 산책을 습관화할 수 있어요"
        case .three:
            return "실시간 산책 동선을 기록하면서\n자유롭게 사진을 찍고 떠오른 생각을 남겨보아요"
        case .four:
            return "그동안의 산책과 생각들을 추억할 수 있어요"
        }
    }
}

class OnboardingView: BaseView {
    
    // MARK: - UI Components
    
    let pageStackView: UIStackView = .init()
    let titleLabel: UILabel = .init()
    let subLabel: UILabel = .init()
    
    // MARK: - Properties
    
    let type: OnboardingViewType
    
    // MARK: - Initializer
    
    init(type: OnboardingViewType) {
        self.type = type
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        for i in 0...3 {
            let circle = UIView()
            
            if i == type.index {
                circle.backgroundColor = FootprintIOSAsset.Colors.blueM.color
            } else {
                circle.backgroundColor = FootprintIOSAsset.Colors.white3.color
            }
        }
    }
}
