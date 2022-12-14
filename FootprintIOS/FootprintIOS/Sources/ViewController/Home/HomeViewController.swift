//
//  HomeViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import RxDataSources
import SnapKit

class HomeViewController: NavigationBarViewController, View {
    
    typealias Reactor = HomeReactor
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<MonthSectionModel>
    
    // MARK: - Properties
    
    lazy var monthDataSource = DataSource { [weak self] _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .month(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MonthCollectionViewCell.self), for: indexPath) as? MonthCollectionViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
        }
    }

    let width = UIScreen.main.bounds.width
    var leftInsetConstraint: Constraint?
    var monthRow: CGFloat = 0
    
    // MARK: - UI Components
    
    private let todayInfoView = UIView().then {
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .init(white: 1, alpha: 0.15)
    }
    
    private let todayInfo = UILabel().then {
        let now = Date()
        $0.text = "\(now.year).\(now.month).\(now.day) \(now.weekday) | 1° 맑음"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(FootprintIOSAsset.Images.homeSettingIcon.image, for: .normal)
    }
    
    private let titleLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .bold(string: "발자국", fontSize: 24)
            .regular(string: "님!\n오늘도 발자국을 남겨볼까요?", fontSize: 24)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    private let homeView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 20, direct: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    
    private let todayButton = UIButton().then {
        $0.setTitle("오늘", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueD.color, for: .selected)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let monthButton = UIButton().then {
        $0.setTitle("이번 달", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueD.color, for: .selected)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
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
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let homeContentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let todayView = TodayView()
    private let monthView = MonthView()
    
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
        
        homeContentScrollView.rx.didEndDragging
            .map { _ in .didEndScroll }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        todayButton.rx.tap
            .map { .tapHomeViewTypeButton(.today) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        monthButton.rx.tap
            .map { .tapHomeViewTypeButton(.month) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        todayView.todaySegmentControl.rx.selectedSegmentIndex
            .map { index in
                    .tapTodayDataButton(TodayDataType(rawValue: index) ?? .percent)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.homeViewType)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { (this, type) in
                let homeX = (type == .today) ? 0 : self.width
                this.todayButton.isSelected = (type == .today)
                this.monthButton.isSelected = (type == .month)
                this.homeContentScrollView.setContentOffset(CGPoint(x: homeX, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.indicatorX)
            .withUnretained(self)
            .bind { (this, x) in
                this.leftInsetConstraint?.update(inset: x)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.didEndScroll)
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .bind { (this, x) in
                let homeX = x > (Int(this.width) / 2) ? this.width : 0
                this.homeContentScrollView.setContentOffset(CGPoint(x: homeX, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.todayDataType)
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { (this, type) in
                // 달성률, 산책시간
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.monthSections)
            .bind(to: monthView.collectionView.rx.items(dataSource: monthDataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.monthRow)
            .withUnretained(self)
            .bind { (this, _) in
                this.monthRow = reactor.currentState.monthRow
            }
            .disposed(by: disposeBag)
        
        monthView.collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = monthView.collectionView.frame.width
        let height = monthView.collectionView.frame.height
        
        let cellWidth = width / 7.0
        let cellHeight = height / monthRow
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
