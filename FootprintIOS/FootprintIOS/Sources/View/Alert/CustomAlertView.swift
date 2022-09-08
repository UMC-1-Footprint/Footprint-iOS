//
//  CustomAlertView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class CustomAlertView: BaseView {
    
    // MARK: - Properties
    
    let type: AlertType

    // MARK: - UI Components
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    // FIXME: 나중에 재사용 가능성이 있다면 customView도 enum으로 관리
    private let customView = UIView().then {
        $0.backgroundColor = .systemYellow
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackM.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    lazy var rightButton = UIButton().then {
        $0.setTitleColor(FootprintIOSAsset.Colors.blueM.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.addArrangedSubview(cancelButton)
        $0.addArrangedSubview(rightButton)
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    // MARK: - Initializer
    
    init(type: AlertType) {
        self.type = type
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = type.title
        rightButton.setTitle(type.buttonTitle, for: .normal)
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(backgroundView)
        backgroundView.addSubviews([titleLabel, customView, lineView, buttonStackView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(326)
            $0.height.equalTo(259)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(23)
            $0.centerX.equalTo(backgroundView)
        }
        
        customView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(backgroundView)
            $0.height.equalTo(150)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(backgroundView)
            $0.height.equalTo(56)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(buttonStackView.snp.top)
            $0.leading.trailing.equalTo(backgroundView)
            $0.height.equalTo(1)
        }
    }
}
