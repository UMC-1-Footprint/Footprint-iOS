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
    
    var pushInfoScreen: () -> InfoViewController
    
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
    
    private lazy var stackView = UIStackView().then {
        $0.addArrangedSubview(infoButton)
        $0.addArrangedSubview(alertButton)
        $0.addArrangedSubview(homeButton)
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    // MARK: - Initializer
    
    init(reactor: Reactor,
         pushInfoScreen: @escaping () -> InfoViewController) {
        self.pushInfoScreen = pushInfoScreen
        
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
            .bind { [weak self] in
                self?.makeAlert(type: .delete)
            }
            .disposed(by: disposeBag)
        
        homeButton.rx.tap
            .bind { [weak self] in
                let homeVC = HomeViewController(reactor: .init())
                self?.tabBarController?.tabBar.backgroundColor = .white
                self?.navigationController?.pushViewController(homeVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func goToInfoScreen() {
        let controller = self.pushInfoScreen()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
