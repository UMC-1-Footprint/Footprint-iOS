//
//  GoalWalkBottomSheetViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

final class GoalWalkBottomSheetViewController: BottomSheetViewController, View {
    
    typealias Reactor = GoalWalkBottomSheetReactor
    
    // MARK: - Properties
    
    private let texts = ["15분", "30분", "1시간", "1시간 30분", "직접 설정"]
    
    // MARK: - UI Components
    
    private let contentView = UIView.init()
    
    private let titleLabel = UILabel().then {
        $0.text = "목표 산책 시간"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private var stackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 30
        $0.axis = .vertical
    }
    
    private var goalWalkLabels = [UILabel]()
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(type: .drag)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([titleLabel, stackView])
        
        addContentView(view: contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(320)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
        }
    }
    
    private func setGoalWalkLabels() {
        for idx in 0..<5 {
            let goalWalkLabel = UILabel().then {
                $0.text = texts[idx]
                $0.font = .systemFont(ofSize: 14)
            }
            stackView.addArrangedSubview(goalWalkLabel)
            goalWalkLabels.append(goalWalkLabel)
        }
    }
    
    // MARK: - Methods
    
    func bind(reactor: GoalWalkBottomSheetReactor) {
        setGoalWalkLabels()
        
        for goalWalk in 0..<5 {
            goalWalkLabels[goalWalk].rx.tapGesture()
                .when(.recognized)
                .withUnretained(self)
                .map { owner, _ -> String in
                    return owner.texts[goalWalk]
                }
                .map { .tapGoalWalkTime($0) }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        }
        
        reactor.state
            .map(\.dismiss)
            .withUnretained(self)
            .bind { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
