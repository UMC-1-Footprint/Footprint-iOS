//
//  GoalEditThisMonthViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import SnapKit

final class GoalEditThisMonthViewController: NavigationBarViewController, View {
    
    typealias Reactor = GoalEditThisMonthReactor
    
    // MARK: - Properties
    
    private var pushGoalEditNextMonthScreen: () -> GoalEditNextMonthViewController
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel().then {
        $0.text = "\(Date().year)년 \(Date().month)월"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    
    private let thisMonthMsgLabel = UILabel().then {
        $0.text = "이번달 목표는 수정할 수 없어요"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = FootprintIOSAsset.Colors.blackM.color
    }
    
    private let goalView = GoalView.init(frame: .zero)
    
    private let goalEditNextMonthButton = UIButton().then {
        $0.setTitle("다음달부터 목표를 변경할래요 >", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueM.color, for: .normal)
    }
    
    private let buttonUnderLineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueM.color
    }
    
    // MARK: - Initiailzer
    
    init(reactor: Reactor, pushGoalEditNextMonthScreen: @escaping () -> GoalEditNextMonthViewController) {
        self.pushGoalEditNextMonthScreen = pushGoalEditNextMonthScreen
        
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
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([dateLabel, thisMonthMsgLabel, goalView, goalEditNextMonthButton, buttonUnderLineView])
    }
    
    override func setupLayout() {
        super.setupLayout()

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(84)
            $0.centerX.equalToSuperview()
        }
        
        thisMonthMsgLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        goalView.snp.makeConstraints {
            $0.top.equalTo(thisMonthMsgLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(goalView.walkSelectView.snp.bottom)
        }
        
        goalEditNextMonthButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(goalView.snp.bottom).offset(56)
        }
        
        buttonUnderLineView.snp.makeConstraints {
            $0.top.equalTo(goalEditNextMonthButton.snp.bottom)
            $0.leading.trailing.equalTo(goalEditNextMonthButton)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Methods
    
    func bind(reactor: GoalEditThisMonthReactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        goalEditNextMonthButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.willPushGoalEditNextMonthScreen()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.goalInfo)
            .withUnretained(self)
            .bind { owner, goalInfo in
                owner.goalView.updateDayButtons(days: goalInfo.dayIdx)
                owner.goalView.walkSelectView.update(text: goalInfo.walkTimeSlot)
                owner.goalView.goalWalkSelectView.update(text: goalInfo.walkGoalTime)
                [owner.goalView.walkSelectView.selectButton, owner.goalView.goalWalkSelectView.selectButton].forEach {
                    $0.isHidden = true
                }
            }
            .disposed(by: disposeBag)
    }
}

extension GoalEditThisMonthViewController {
    private func willPushGoalEditNextMonthScreen() {
        let controller = self.pushGoalEditNextMonthScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
