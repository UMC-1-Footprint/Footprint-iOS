//
//  GoalView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/01.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

class GoalView: BaseView {
    
    // MARK: - UI Components
    
    lazy var dayButtons: [UIButton] = []
    
    let button = UIButton().then {
        $0.setTitle("버튼", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackM.color, for: .normal)
    }
    
    private let dayButtonStackView = UIStackView().then {
        $0.spacing = 5
        $0.alignment = .center
    }
    
    private let goalDayLabel = UserInfoLabel(title: "목표 요일")
    private let goalTimeLabel = UserInfoLabel(title: "목표 산책 시간")
    private let timeLabel = UserInfoLabel(title: "산책 시간대")
    
    let goalWalkSelectView = UserInfoSelectBar(type: .goalTime)
    let walkSelectView  = UserInfoSelectBar(type: .time)
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
    
        for day in ["월", "화", "수", "목", "금", "토", "일"] {
            let dayButton = UIButton().then {
                $0.layer.cornerRadius = 20
                $0.setTitleColor(FootprintIOSAsset.Colors.blackD.color, for: .normal)
                $0.setTitleColor(.white, for: .selected)
                $0.layer.borderColor = FootprintIOSAsset.Colors.white3.color.cgColor
                $0.layer.borderWidth = 1
                $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            }
            dayButton.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            dayButton.setTitle(day, for: .normal)
            dayButtons.append(dayButton)
            dayButtonStackView.addArrangedSubview(dayButton)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([button, goalDayLabel, dayButtonStackView, goalTimeLabel, goalWalkSelectView, timeLabel, walkSelectView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        button.snp.makeConstraints() {
            $0.top.centerX.equalToSuperview()
        }
        
        goalDayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(button.snp.bottom)
        }
        
        dayButtonStackView.snp.makeConstraints {
            $0.top.equalTo(goalDayLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        goalTimeLabel.snp.makeConstraints {
            $0.top.equalTo(dayButtonStackView.snp.bottom).offset(34)
            $0.leading.equalTo(goalDayLabel)
        }
        
        goalWalkSelectView.snp.makeConstraints {
            $0.top.equalTo(goalTimeLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(34)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(goalWalkSelectView.snp.bottom).offset(34)
            $0.leading.equalTo(goalDayLabel)
        }
        
        walkSelectView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(34)
        }
    }
}
