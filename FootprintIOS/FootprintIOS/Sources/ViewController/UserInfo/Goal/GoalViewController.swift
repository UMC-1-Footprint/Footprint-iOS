//
//  GoalViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/08/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

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
    
    private let goalView: GoalView = .init(frame: .zero)
    
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
        
        bottomButton.setupEnabled(isEnabled: true)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        selectedPageCircle.addSubview(pageNumLabel)
        view.addSubviews([pageStackView, titleLabel, subtitleLabel, goalView, bottomButton])
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
        
        goalView.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.bottom.equalTo(bottomButton.snp.top)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(70)
        }
    }
    
    func bind(reactor: Reactor) {
        
        for day in 0..<7 {
            goalView.dayButtons[day].rx.tap
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
        
        goalView.walkSelectView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { owner, _ in
                let reactor = reactor.reactorForWalk()
                let walkBottomSheet = WalkBottomSheetViewController(reactor: reactor)
                owner.present(walkBottomSheet, animated: true)
            }
            .disposed(by: disposeBag)
        
        goalView.goalWalkSelectView.rx.tapGesture()
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
                    owner.goalView.dayButtons[day].isSelected = isSelectedDays[day]
                    
                    if isSelectedDays[day] {
                        owner.goalView.dayButtons[day].layer.borderColor = FootprintIOSAsset.Colors.blueM.color.cgColor
                        owner.goalView.dayButtons[day].backgroundColor = FootprintIOSAsset.Colors.blueM.color
                    } else {
                        owner.goalView.dayButtons[day].layer.borderColor = FootprintIOSAsset.Colors.white3.color.cgColor
                        owner.goalView.dayButtons[day].backgroundColor = .white
                    }
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.goalWalk)
            .withUnretained(self)
            .bind { owner, goalWalk in
                owner.goalView.goalWalkSelectView.update(text: goalWalk)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.walk)
            .withUnretained(self)
            .bind { owner, walk in
                owner.goalView.walkSelectView.update(text: walk)
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
