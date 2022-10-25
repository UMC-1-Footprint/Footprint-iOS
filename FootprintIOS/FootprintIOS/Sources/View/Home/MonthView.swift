//
//  MonthView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/10.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class MonthView: BaseView {
    
    // MARK: - UI Components
    
    let monthLabel = UILabel().then {
        $0.text = "2022년 9월"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
    }
    
    let collectionView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let timeLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "총 시간 \n", fontSize: 12)
            .bold(string: "135", fontSize: 24)
            .regular(string: " 시간", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let distanceLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "거리 \n", fontSize: 12)
            .bold(string: "2.1", fontSize: 24)
            .regular(string: " km", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let calorieLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "칼로리 \n", fontSize: 12)
            .bold(string: "120", fontSize: 24)
            .regular(string: " kcal", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let line1View = UIView()
    let line2View = UIView()
    
    lazy var monthStackView = UIStackView().then {
        $0.addArrangedSubviews(timeLabel, line1View, distanceLabel, line2View, calorieLabel)
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 10
        $0.axis = .horizontal
    }
    
    private let bottomButton = FootprintButton(type: .startWalk)
    
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        [line1View, line2View].forEach {
            $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([monthLabel, collectionView, monthStackView, bottomButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        monthLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(monthLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(monthStackView.snp.top).offset(-10)
        }
        
        [line1View, line2View].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(1)
                $0.height.equalTo(35)
            }
        }
        
        monthStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
