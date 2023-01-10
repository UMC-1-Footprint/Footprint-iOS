//
//  CalendarViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/23.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import ReactorKit

class CalendarViewController: NavigationBarViewController, View {
    
    typealias Reactor = CalendarReactor
    
    // MARK: - Properties
    
    private let pushInfoScreen: () -> InfoViewController
    private let pushGoalEditThisMonthScreen: () -> GoalEditThisMonthViewController
    
    // MARK: - UI Components
    
    private lazy var infoButton = UIButton().then {
        $0.setTitle("정보 입력", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private lazy var alertButton = UIButton().then {
        $0.setTitle("알림창 띄우기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private lazy var homeButton = UIButton().then {
        $0.setTitle("홈", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private lazy var goalEditButton = UIButton().then {
        $0.setTitle("목표 수정", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.addArrangedSubviews(infoButton, alertButton, homeButton, goalEditButton)
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    // MARK: - Initializer
    
    init(reactor: Reactor,
         pushInfoScreen: @escaping () -> InfoViewController,
         pushGoalEditThisMonthScreen: @escaping () -> GoalEditThisMonthViewController) {
        self.pushInfoScreen = pushInfoScreen
        self.pushGoalEditThisMonthScreen = pushGoalEditThisMonthScreen
        
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("캘린더")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([stackView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind(reactor: CalendarReactor) {
        infoButton.rx.tap
            .bind { [weak self] in
                self?.goToInfoScreen()
            }
            .disposed(by: disposeBag)
        
        alertButton.rx.tap
            .withUnretained(self)
            .flatMap { owner, _ in
                let delete: PublishSubject<Bool> = .init()
                
                owner.makeAlert(type: .delete, alertAction: {
                    delete.onNext(true)
                })
                
                return delete
            }
            .map { _ in .delete }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        homeButton.rx.tap
            .bind { [weak self] in
                let homeVC = HomeViewController(reactor: .init())
                self?.tabBarController?.tabBar.backgroundColor = .white
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        goalEditButton.rx.tap
            .bind { [weak self] in
                self?.willPushGoalEditThisMonthScreen()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isDeleted)
            .withUnretained(self)
            .bind { owner, isDeleted in
                print("\(isDeleted)")
            }
            .disposed(by: disposeBag)
    }
}

extension CalendarViewController {
    private func goToInfoScreen() {
        let controller = self.pushInfoScreen()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func willPushGoalEditThisMonthScreen() {
        let controller = self.pushGoalEditThisMonthScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
