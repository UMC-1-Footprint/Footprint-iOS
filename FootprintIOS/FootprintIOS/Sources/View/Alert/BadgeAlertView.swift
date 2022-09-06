//
//  BadgeAlertView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class BadgeAlertView: BaseView {
    
    // MARK: - Properties
    
    let type: AlertType
    
    // MARK: - UI Components
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }
    
    private let badgeBackgroundImageView = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.badgeShineImage.image
    }
    
    private let badgeImageView = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.startBadge.image
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var confirmButton = UIButton().then {
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
        
        self.isHidden = true
        titleLabel.text = type.title
    }

    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(backgroundView)
        badgeBackgroundImageView.addSubview(badgeImageView)
        backgroundView.addSubviews([badgeBackgroundImageView, titleLabel, lineView, confirmButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(327)
            $0.height.equalTo(280)
            $0.center.equalToSuperview()
        }
        
        badgeImageView.snp.makeConstraints {
            $0.center.equalTo(badgeBackgroundImageView)
            $0.width.height.equalTo(126)
        }
        
        badgeBackgroundImageView.snp.makeConstraints {
            $0.top.equalTo(backgroundView).offset(28)
            $0.centerX.equalTo(backgroundView)
            $0.width.equalTo(194)
            $0.height.equalTo(123)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(badgeBackgroundImageView.snp.bottom).offset(10)
            $0.centerX.equalTo(badgeImageView)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top)
            $0.leading.trailing.equalTo(backgroundView)
            $0.height.equalTo(1)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.centerX.equalTo(backgroundView)
            $0.height.equalTo(56)
        }
    }
}
