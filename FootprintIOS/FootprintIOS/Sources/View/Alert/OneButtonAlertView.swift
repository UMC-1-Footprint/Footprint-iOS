//
//  OneButtonAlertView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class OneButtonAlertView: BaseView {
    
    // MARK: - Properties
    
    let type: AlertType
    
    // MARK: - UI Components
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    
    lazy var confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueM.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
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
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(backgroundView)
        backgroundView.addSubviews([titleLabel, lineView, confirmButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(340)
            $0.height.equalTo(140)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView).offset(37)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(backgroundView)
            $0.height.equalTo(1)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.centerX.equalTo(backgroundView)
        }
    }
}
