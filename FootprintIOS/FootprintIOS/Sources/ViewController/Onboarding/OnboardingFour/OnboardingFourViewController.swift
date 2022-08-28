//
//  OnboardingFourViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class OnboardingFourViewController: NavigationBarViewController, View {
    typealias Reactor = OnboardingReactor
    
    // MARK: - UI Components
    
    let onboardingView: OnboardingView = .init(type: .four)
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([onboardingView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        onboardingView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind(reactor: Reactor) {
        // Action
        onboardingView.bottomButton
            .rx
            .tap
            .map { .tapBottomButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map(\.isPresent)
            .distinctUntilChanged()
            .filter { $0 }
            .bind { [weak self] _ in
                //TODO: 로그인 페이지 이동
            }
            .disposed(by: disposeBag)
    }
}
