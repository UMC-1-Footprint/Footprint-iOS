//
//  FootprintGoalView.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit

enum GoalCase {
    case date
    case time
    case timeZone
}

class FootprintGoalView: BaseView {
    let goalType: GoalCase
    let userGoal: String
    let icon: UIImageView = .init()
    let noticeLable: UILabel = .init()
    let goalLabel: UILabel = .init()
    
    init(goalType: GoalCase, userGoal: String) {
        self.goalType = goalType
        self.userGoal = userGoal
        
        super.init(frame: .zero)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        icon.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.leading.equalToSuperview().offset(4)
            $0.centerY.equalToSuperview()
        }
        
        noticeLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(icon.snp.trailing).offset(8)
        }
        
        goalLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([icon, noticeLable, goalLabel])
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        switch goalType {
        case .date:
            icon.image = FootprintIOSAsset.Images.myFootprintCalendarIcon.image
            noticeLable.text = "목표 요일"
        case .time:
            icon.image = FootprintIOSAsset.Images.myFootprintTimeIcon.image
            noticeLable.text = "목표 산책시간"
        case .timeZone:
            icon.image = FootprintIOSAsset.Images.myFootprintSunIcon.image
            noticeLable.text = "산책 시간대"
        }
        
        noticeLable.textColor = FootprintIOSAsset.Colors.blackM.color
        noticeLable.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 300))
        
        goalLabel.textColor = FootprintIOSAsset.Colors.blueM.color
        goalLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 300))
        goalLabel.text = userGoal
    }
}
