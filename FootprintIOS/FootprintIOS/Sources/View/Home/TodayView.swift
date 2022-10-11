//
//  TodayView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/10.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class TodayView: BaseView {
    
    // MARK: - UI Components
    
    private let todayContentView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private let todaySegmentControl = UISegmentedControl(items: ["달성률", "산책시간"]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color.withAlphaComponent(0.5)
        $0.selectedSegmentTintColor = FootprintIOSAsset.Colors.blueM.color
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .selected)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : FootprintIOSAsset.Colors.blackL.color, .font: UIFont.systemFont(ofSize: 12)], for: .normal)
        $0.selectedSegmentIndex = 0
        $0.layer.cornerRadius = 15
    }
    
    private let distanceLabel = UILabel().then {
        $0.text = "거리 \n 2.1 km"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let calorieLabel = UILabel().then {
        $0.text = "칼로리 \n 120 kcal"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    
    private let bottomButton = FootprintButton(type: .startWalk)
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([todayContentView, todaySegmentControl, distanceLabel, lineView, calorieLabel, bottomButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayContentView.snp.makeConstraints {
            $0.width.height.equalTo(230)
            $0.top.equalToSuperview().inset(39)
            $0.centerX.equalToSuperview()
        }
        
        todaySegmentControl.snp.makeConstraints {
            $0.top.equalTo(todayContentView.snp.bottom).offset(19)
            $0.width.equalTo(115)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(todaySegmentControl.snp.bottom).offset(22)
            $0.leading.equalToSuperview().inset(74)
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(35)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(distanceLabel)
        }
        
        calorieLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel)
            $0.trailing.equalToSuperview().inset(74)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
