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
        $0.layer.cornerRadius = 100
    }
    
    private let todayFootprintImageView = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.homeFootprintGray.image
    }
    
    private let todayFootprintLabel = UILabel().then {
        $0.text = "0%"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    private lazy var todayStackView = UIStackView().then {
        $0.addArrangedSubview(todayFootprintImageView)
        $0.addArrangedSubview(todayFootprintLabel)
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 10
        $0.axis = .vertical
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
    
    override func draw(_ rect: CGRect) {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let layer = CAShapeLayer()
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height * (155/812)),
                                           radius: 110,
                                           startAngle: 0,
                                           endAngle: 360,
                                           clockwise: true)
        FootprintIOSAsset.Colors.whiteD.color.setStroke()
        progressPath.lineWidth = 15
        progressPath.stroke()
        
        let progressBarPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height * (155/812)),
                                           radius: 110,
                                           startAngle: 0,
                                           endAngle: (135 * .pi) / 180,
                                           clockwise: true)
        FootprintIOSAsset.Colors.blueM.color.setStroke()
        progressBarPath.lineWidth = 15
        progressBarPath.stroke()
    }
    
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
            $0.width.height.equalTo(200)
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
