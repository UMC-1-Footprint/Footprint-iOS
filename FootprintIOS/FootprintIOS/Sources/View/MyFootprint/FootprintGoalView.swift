//
//  FootprintGoalView.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//
//  마이페이지 - 산책 목표
 
import UIKit

import SnapKit

enum GoalCase {
    case date
    case time
    case timeZone
    
    var image: UIImage {
        switch self {
        case .date:
            return FootprintIOSAsset.Images.myFootprintCalendarIcon.image
        case .time:
            return FootprintIOSAsset.Images.myFootprintTimeIcon.image
        case .timeZone:
            return FootprintIOSAsset.Images.myFootprintSunIcon.image
        }
    }
    
    var text: String {
        switch self {
        case .date:
            return "목표 요일"
        case .time:
            return "목표 산책시간"
        case .timeZone:
            return "산책 시간대"
        }
    }
}

class FootprintGoalView: BaseView {
    let goalType: GoalCase
    let userGoal: String
    let icon: UIImageView = .init()
    let noticeLable: UILabel = .init()
    let goalLabel: UILabel = .init()
    lazy var goalIcon: UIImage = goalType.image
    lazy var goalText: String = goalType.text
    
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
        
        icon.image = goalIcon
        noticeLable.text = goalText
        noticeLable.textColor = FootprintIOSAsset.Colors.blackM.color
        noticeLable.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 300))
        
        goalLabel.textColor = FootprintIOSAsset.Colors.blueM.color
        goalLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 300))
        goalLabel.text = userGoal
    }
}
