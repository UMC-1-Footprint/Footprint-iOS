//
//  TwoButtonAlertView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class TwoButtonAlertView: BaseView {
    
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
    
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var titleStackView = UIStackView().then {
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(subTitleLabel)
        $0.spacing = 15
        $0.axis = .vertical
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackM.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private lazy var rightButton = UIButton().then {
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
        
        self.isHidden = true
        titleLabel.text = type.title
        subTitleLabel.text = type.subTitle
        rightButton.setTitle(type.buttonTitle, for: .normal)
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(backgroundView)
        backgroundView.addSubviews([titleStackView, lineView, buttonStackView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            if (type.subTitle == "") {
                $0.width.equalTo(327)
            } else {
                $0.width.equalTo(340)
            }
            $0.height.equalTo(200)
            $0.center.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            if (type.subTitle == "") {
                $0.top.equalTo(backgroundView).offset(72)
            } else if (type == .deleteAll){
                $0.top.equalTo(backgroundView).offset(52)
            } else {
                $0.top.equalTo(backgroundView).offset(59)
            }
            $0.centerX.equalTo(backgroundView)
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
