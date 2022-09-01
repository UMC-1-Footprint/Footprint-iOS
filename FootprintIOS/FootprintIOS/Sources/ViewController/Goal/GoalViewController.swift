//
//  GoalViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/08/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import Then

class GoalViewController: NavigationBarViewController, View {
    
    // MARK: - Properties
    
    typealias Reactor = GoalReactor
    
    // MARK: - UI Components
    
    private let selectedPageCircle = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueM.color
        $0.layer.cornerRadius = 7
    }
    
    private let pageNumLabel = UILabel().then {
        $0.text = "2"
        $0.font = .systemFont(ofSize: 11, weight: .semibold)
        $0.textColor = .white
    }
    
    private let unSelectedPageCircle = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
        $0.layer.cornerRadius = 3
    }
    
    private let pageStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "목표를 설정해 주세요"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "월 기준으로 목표를 설정할 수 있어요"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    private var dayButtons: [UIButton] = []
    
    private let dayButtonStackView = UIStackView().then {
        $0.spacing = 5
        $0.alignment = .center
    }
    
    private let line1View = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let goalDayLabel = UILabel().then {
        $0.text = "목표 요일"
    }
    
    private let goalTimeLabel = UILabel().then {
        $0.text = "목표 산책 시간"
    }
    
    private let goalTimeSelectView = SelectBar(type: .goalTime)
    
    private let line2View = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "산책 시간대"
    }
    
    private let timeSelectView  = SelectBar(type: .time)
    
    private lazy var bottomButton: UIButton = FootprintButton.init(type: .complete)

    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        pageStackView.addArrangedSubview(unSelectedPageCircle)
        pageStackView.addArrangedSubview(selectedPageCircle)
        
        [goalDayLabel, goalTimeLabel, timeLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        
        for day in ["월", "화", "수", "목", "금", "토", "일"] {
            let dayButton = UIButton().then {
                $0.layer.cornerRadius = 20
                $0.setTitleColor(FootprintIOSAsset.Colors.blackD.color, for: .normal)
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
        
        selectedPageCircle.addSubview(pageNumLabel)
        view.addSubviews([pageStackView, titleLabel, subtitleLabel, goalDayLabel,
                         dayButtonStackView, line1View, goalTimeLabel, goalTimeSelectView,
                          line2View, timeLabel, timeSelectView, bottomButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        selectedPageCircle.snp.makeConstraints {
            $0.height.width.equalTo(14)
        }
        
        pageNumLabel.snp.makeConstraints {
            $0.center.equalTo(selectedPageCircle)
        }
        
        unSelectedPageCircle.snp.makeConstraints {
            $0.height.width.equalTo(6)
        }
        
        pageStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(pageStackView.snp.bottom).offset(34)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        goalDayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(34)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
        }
        
        dayButtonStackView.snp.makeConstraints {
            $0.top.equalTo(goalDayLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        line1View.snp.makeConstraints {
            $0.top.equalTo(dayButtonStackView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(7)
        }
        
        goalTimeLabel.snp.makeConstraints {
            $0.top.equalTo(line1View.snp.bottom).offset(34)
            $0.leading.equalTo(goalDayLabel)
        }
        
        goalTimeSelectView.snp.makeConstraints {
            $0.top.equalTo(goalTimeLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        line2View.snp.makeConstraints {
            $0.top.equalTo(goalTimeSelectView.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(7)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(line2View.snp.bottom).offset(34)
            $0.leading.equalTo(goalDayLabel)
        }
        
        timeSelectView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(70)
        }
    }
    
    func bind(reactor: GoalReactor) {
        // Action
        // State
    }
}
