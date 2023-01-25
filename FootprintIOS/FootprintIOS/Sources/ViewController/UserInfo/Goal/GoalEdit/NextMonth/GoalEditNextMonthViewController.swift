//
//  GoalEditNextMonthViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

final class GoalEditNextMonthViewController: NavigationBarViewController, View {
    
    typealias Reactor = GoalEditNextMonthReactor
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel().then {
        $0.text = Date().calculateDate(type: .month, value: 1).toString(dateFormat: "YYYY년 M월")
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    
    private let nextMonthMsgLabel = UILabel().then {
        $0.text = "목표를 수정하면 다음 달부터 적용돼요"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    private let goalView = GoalView.init(frame: .zero)
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("산책 목표")
        setNavigationBarBackButtonImage(FootprintIOSAsset.Images.backButtonIcon.image)
        setNavigationBarTitleFont(.systemFont(ofSize: 16, weight: .semibold))
        
        setNavigationRightButtonTitle("저장")
        setNavigationBarRightButtonTitleColor(FootprintIOSAsset.Colors.blueM.color)
        setNavigationBarRightButtonTitleFont(.systemFont(ofSize: 16, weight: .semibold))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([dateLabel, nextMonthMsgLabel, goalView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(84)
            $0.centerX.equalToSuperview()
        }
        
        nextMonthMsgLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        goalView.snp.makeConstraints {
            $0.top.equalTo(nextMonthMsgLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(goalView.walkSelectView.snp.bottom)
        }
    }
    
    // MARK: - Methods
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        for day in 0..<goalView.dayButtons.count {
            goalView.dayButtons[day].rx.tap
                .map { .tapDayButton(day) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
        
        navigationBar.rightButton.rx.tap
            .withUnretained(self)
            .map { owner, _ -> GoalRequestDTO in
                let info = GoalRequestDTO(dayIdx: reactor.currentState.isSelectedButtons.enumerated().filter { $0.1 }.map { $0.0 + 1 },
                                          walkGoalTime: owner.goalView.getWalkIndex(type: .goalTime),
                                          walkTimeSlot: owner.goalView.getWalkIndex(type: .time))
                
                return info
            }
            .map { .tapSaveButton($0) }
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
            .compactMap(\.goalInfo)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, goalInfo in
                owner.goalView.updateDayButtons(days: goalInfo.dayIdx)
                owner.goalView.walkSelectView.update(text: goalInfo.walkTimeSlot)
                owner.goalView.goalWalkSelectView.update(text: goalInfo.walkGoalTime)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedButtons)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, isSelectedDays in
                for day in 0..<owner.goalView.dayButtons.count {
                    isSelectedDays[day] ? owner.goalView.updateDayButtonIsSelected(day: day) : owner.goalView.updateDayButtonIsUnSelected(day: day)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.goalWalk)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, goalWalk in
                owner.goalView.goalWalkSelectView.update(text: goalWalk)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.walk)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, walk in
                owner.goalView.walkSelectView.update(text: walk)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.save)
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind { owner, isSuccess in
                if isSuccess {
                    owner.makeAlert(type: .changeGoal)
                } else {
                    owner.makeAlert(type: .noGoal)
                }
            }
            .disposed(by: disposeBag)
    }
}
