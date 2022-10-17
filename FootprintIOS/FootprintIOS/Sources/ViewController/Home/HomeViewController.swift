//
//  HomeViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import SnapKit

class HomeViewController: NavigationBarViewController, View {
    
    // MARK: - Properties
    
    typealias Reactor = HomeReactor
    let width = UIScreen.main.bounds.width
    var leftInsetConstraint: Constraint?
    
    // MARK: - UI Components
    
    private let todayInfoView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .init(white: 1, alpha: 0.15)
    }
    
    private let todayInfo = UILabel().then {
        $0.text = "2022.9.9 목 | 1° 맑음"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(FootprintIOSAsset.Images.homeSettingIcon.image, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "발자국님!\n오늘도 발자국을 남겨볼까요?"
        $0.font = .systemFont(ofSize: 24)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    private let homeView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 20, direct: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    
    private let todayButton = UIButton().then {
        $0.setTitle("오늘", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueD.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let monthButton = UIButton().then {
        $0.setTitle("이번 달", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    private lazy var tabButtonStackView = UIStackView().then {
        $0.addArrangedSubview(todayButton)
        $0.addArrangedSubview(monthButton)
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    private let indicatorBar = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueD.color
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    
    private let homeContentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let homeContentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let todayView = TodayView()
    private let monthView = MonthView()
    private let startWalkButton = FootprintButton(type: .startWalk)
    
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
        
        view.backgroundColor = .systemBlue
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([todayInfoView, settingButton, titleLabel, homeView])
        todayInfoView.addSubview(todayInfo)
        homeView.addSubviews([tabButtonStackView, indicatorBar, lineView, homeContentScrollView])
        homeContentScrollView.addSubview(homeContentView)
        homeContentView.addSubviews([todayView, monthView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(53)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(30)
            $0.width.equalTo(145)
        }
        
        todayInfo.snp.makeConstraints {
            $0.center.equalTo(todayInfoView)
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalTo(todayInfoView)
            $0.width.height.equalTo(19)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(todayInfoView.snp.bottom).offset(17)
            $0.leading.equalTo(24)
        }
        
        homeView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabButtonStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(homeView)
            $0.height.equalTo(37)
        }
        
        indicatorBar.snp.makeConstraints {
            let tabWidth = self.width * (52/375)
            $0.top.equalTo(tabButtonStackView.snp.bottom)
            $0.height.equalTo(4)
            $0.width.equalTo(89)
            $0.left.greaterThanOrEqualToSuperview().inset(tabWidth)
            $0.right.lessThanOrEqualToSuperview().inset(tabWidth)
            self.leftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(indicatorBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        homeContentScrollView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(homeView)
        }
        
        homeContentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(homeContentScrollView)
            $0.height.equalTo(homeContentScrollView.snp.height)
        }
        
        todayView.snp.makeConstraints {
            $0.top.leading.equalTo(homeContentView)
            $0.width.equalTo(width)
            $0.height.equalTo(homeContentView)
        }
        
        monthView.snp.makeConstraints {
            $0.top.equalTo(homeContentView)
            $0.leading.equalTo(todayView.snp.trailing)
            $0.width.equalTo(width)
            $0.height.equalTo(homeContentView)
            $0.trailing.equalTo(homeContentView.snp.trailing)
        }
    }
    
    func bind(reactor: HomeReactor) {
        homeContentScrollView.rx.contentOffset
            .map { .scrollHomeContent(x: Int($0.x)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        homeContentScrollView.rx.didEndDecelerating
            .map { .didEndScroll }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        todayButton.rx.tap
            .map { .tapTodayButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        monthButton.rx.tap
            .map { .tapMonthButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isTodayView)
            .distinctUntilChanged()
            .filter { $0 }
            .bind { [weak self] _ in
                self?.homeContentScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isMonthView)
            .distinctUntilChanged()
            .filter { $0 }
            .bind { [weak self] _ in
                self?.homeContentScrollView.setContentOffset(CGPoint(x: self?.width ?? 0, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.indicatorX)
            .bind { x in
                self.leftInsetConstraint?.update(inset: x)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.didEndScroll)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { this, x in
                let scaledX = x > (Int(this.width) / 2) ? this.width : 0
                
                this.homeContentScrollView.setContentOffset(CGPoint(x: scaledX, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
