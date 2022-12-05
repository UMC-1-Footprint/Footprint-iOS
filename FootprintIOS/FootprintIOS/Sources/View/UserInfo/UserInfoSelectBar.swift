//
//  UserInfoSelectBar.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

enum UserInfoSelectBarType {
    case birth
    case goalTime
    case time
    
    var title: String {
        switch self {
        case .birth:
            return "생일을 입력해 주세요"
        case .goalTime:
            return "목표시간을 선택해 주세요"
        case .time:
            return "시간대를 선택해 주세요"
        }
    }
}

class UserInfoSelectBar: BaseView {
    
    // MARK: - Properties
    
    let type: UserInfoSelectBarType
    
    // MARK: - UIComponents
    
    private let selectBarView = UIView().then {
        $0.layer.borderColor = FootprintIOSAsset.Colors.whiteD.color.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }
    
    let selectLabel = UILabel().then {
        $0.textColor = FootprintIOSAsset.Colors.whiteD.color
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let selectButton = UIButton().then {
        $0.setImage(FootprintIOSAsset.Images.downButtonIcon.image, for: .normal)
    }
    
    // MARK: - Initiailizer
    
    init(type: UserInfoSelectBarType) {
        self.type = type
        
        super.init(frame: .zero)
        
        selectLabel.text = type.title
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(selectBarView)
        selectBarView.addSubviews([selectLabel, selectButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selectBarView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        selectLabel.snp.makeConstraints {
            $0.center.equalTo(selectBarView)
        }
        
        selectButton.snp.makeConstraints {
            $0.trailing.equalTo(selectBarView.snp.trailing).inset(5)
            $0.centerY.equalTo(selectBarView)
            $0.width.height.equalTo(20)
        }
    }
}


extension UserInfoSelectBar {
    func setContentText(text: String) {
        selectLabel.text = text
        selectLabel.textColor = FootprintIOSAsset.Colors.blackM.color
    }
}
