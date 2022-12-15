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

class GoalViewController: BaseViewController, View {
    
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
    
    private lazy var dayButtons: [UIButton] = []
    
    private let dayButtonStackView = UIStackView().then {
        $0.spacing = 5
        $0.alignment = .center
    }
    
    private let goalDayLabel = UserInfoLabel(title: "목표 요일")
    private let goalTimeLabel = UserInfoLabel(title: "목표 산책 시간")
    private let timeLabel = UserInfoLabel(title: "산책 시간대")
    
    private let goalWalkSelectView = UserInfoSelectBar(type: .goalTime)
    private let walkSelectView  = UserInfoSelectBar(type: .time)
    
    private lazy var bottomButton = FootprintButton.init(type: .complete)

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
        
        bottomButton.setupEnabled(isEnabled: false)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        selectedPageCircle.addSubview(pageNumLabel)
        view.addSubviews([pageStackView, titleLabel, subtitleLabel, goalDayLabel,
                         dayButtonStackView, goalTimeLabel, goalWalkSelectView, timeLabel,
                          walkSelectView, bottomButton])
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
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(pageStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        goalDayLabel.snp.makeConstraints {
            $0.leading.equalTo(subtitleLabel)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
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
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(70)
        }
    }
    
    private func setDayButton() {
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
    
    func bind(reactor: GoalReactor) {
        setDayButton()
        
        for day in 0..<7 {
            dayButtons[day].rx.tap
                .map { .tapDayButton(day) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
        
        bottomButton.rx.tap
            .withUnretained(self)
            .map { owner, _ -> GoalModel in
                let info = GoalModel(dayIdx: reactor.currentState.isSelectedButtons.enumerated().filter { $0.1 }.map { $0.0 + 1 },
                                     walkGoalTime: 0,
                                     walkTimeSlot: 0)
                
                return info
            }
            .map { .tapDoneButton($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        walkSelectView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                let reactor = reactor.reactorForWalk()
                let walkBottomSheet = WalkBottomSheetViewController(reactor: reactor)
                owner.present(walkBottomSheet, animated: true)
            }
            .disposed(by: disposeBag)
        
        goalWalkSelectView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                let reactor = reactor.reactorForGoalWalk()
                let goalWalkBottomSheet = GoalWalkBottomSheetViewController(reactor: reactor)
                owner.present(goalWalkBottomSheet, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedButtons)
            .withUnretained(self)
            .bind { owner, isSelectedDays in
                for day in 0..<7 {
                    owner.dayButtons[day].isSelected = isSelectedDays[day]
                    
                    if isSelectedDays[day] {
                        owner.dayButtons[day].layer.borderColor = FootprintIOSAsset.Colors.blueM.color.cgColor
                        owner.dayButtons[day].backgroundColor = FootprintIOSAsset.Colors.blueM.color
                    } else {
                        owner.dayButtons[day].layer.borderColor = FootprintIOSAsset.Colors.white3.color.cgColor
                        owner.dayButtons[day].backgroundColor = .white
                    }
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.goalWalk)
            .withUnretained(self)
            .bind { owner, goalWalk in
                owner.goalWalkSelectView.update(text: goalWalk)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.walk)
            .withUnretained(self)
            .bind { owner, walk in
                owner.walkSelectView.update(text: walk)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isEnabledDoneButton)
            .withUnretained(self)
            .bind { owner, isEnabled in
                let isEnabled = isEnabled.allSatisfy { $0 }
                owner.bottomButton.setupEnabled(isEnabled: isEnabled)
            }
            .disposed(by: disposeBag)
    }
}
