//
//  TodayView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/10.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum TodayDataType: Int {
    case percent
    case time
}

class TodayView: BaseView {
    
    // MARK: - UI Components
    
    let todayContentView = roundChartView(percent: 80, lineWidth: 10, radius: 110)
    
    let todayFootprintImageView = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.homeFootprintGray.image
    }
    
    let todayFootprintLabel = UILabel().then {
        $0.text = "0%"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    lazy var todayStackView = UIStackView().then {
        $0.addArrangedSubview(todayFootprintImageView)
        $0.addArrangedSubview(todayFootprintLabel)
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    let todaySegmentControl = UISegmentedControl(items: ["달성률", "산책시간"]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color.withAlphaComponent(0.5)
        $0.selectedSegmentTintColor = FootprintIOSAsset.Colors.blueM.color
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .selected)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : FootprintIOSAsset.Colors.blackL.color, .font: UIFont.systemFont(ofSize: 12)], for: .normal)
        $0.selectedSegmentIndex = 0
    }
    
    let distanceLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "거리 \n", fontSize: 12)
            .bold(string: "2.1", fontSize: 24)
            .regular(string: "km", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let calorieLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "칼로리 \n", fontSize: 12)
            .bold(string: "120", fontSize: 24)
            .regular(string: "kcal", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    
    let bottomButton = FootprintButton(type: .startWalk)
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .white
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        todayContentView.addSubview(todayStackView)
        addSubviews([todayContentView, todaySegmentControl, distanceLabel, lineView, calorieLabel, bottomButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayContentView.snp.makeConstraints {
            $0.width.height.equalTo(230)
            $0.top.equalToSuperview().inset(55)
            $0.centerX.equalToSuperview()
        }
        
        todayFootprintImageView.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(65)
        }
        
        todayStackView.snp.makeConstraints {
            $0.center.equalTo(todayContentView)
        }
        
        todaySegmentControl.snp.makeConstraints {
            $0.top.equalTo(todayContentView.snp.bottom).offset(39)
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
