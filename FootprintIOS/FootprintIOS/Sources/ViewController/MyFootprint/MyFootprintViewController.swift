//
//  MyFootprintViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift

class MyFootprintViewController: BaseViewController {
// MARK: - UI Components
    enum TabItem: CaseIterable {
        case dayAchievement
        case monthRecord
        case monthAchievement

        var text: String {
            switch self {
            case .dayAchievement:
                return "요일별 달성률"
            case .monthRecord:
                return "월별 기록 횟수"
            case .monthAchievement:
                return "월별 달성률"
            }
        }
        
        var index: Int {
            switch self {
            case .dayAchievement:
                return 0
            case .monthRecord:
                return 1
            case .monthAchievement:
                return 2
            }
        }
    }
    
    // MARK: - topInfo
    let myFootprintLabel: UILabel = .init()
    let settingButton: UIButton = .init()
    let navigationView: UIView = .init()
    let underlineView: UIView = .init()
    let myFootprintScrollView: UIScrollView = .init()
    let topInfoView: UIView = .init()
    let userBagdeImageView: UIImageView = .init()
    let userNameStackView: UIStackView = .init()
    let userNameLabel: UILabel = .init()
    let userRepresentNicknameLabel: UILabel = .init()
    let moreButton: UIButton = .init()
    
    // MARK: - middleSummary
    lazy var todayChartView =  AttainmentRateChartView(keyColor: FootprintIOSAsset.Colors.blueM.color, petcentageAngle: 90)
    lazy var monthChartView = AttainmentRateChartView(keyColor: FootprintIOSAsset.Colors.yellowM.color, petcentageAngle: 56)
    let monthFootprintView: UIView = .init()
    let monthFootprintCountLabel: UILabel = .init()
    
    let todayChartLabel: UILabel = .init()
    let monthChartLabel: UILabel = .init()
    let monthFootprintLabel: UILabel = .init()
    
    let todayChartStackView: UIStackView = .init()
    let monthChartStackView: UIStackView = .init()
    let monthFootprintCountStackView: UIStackView = .init()
    let middleSummaryStackView: UIStackView = .init()
    
    // MARK: - 산책 목표
    let goalUnderlineView = UnderLineView()
    let goalNavigationView: UIView = .init()
    let goalNavigationLabel: UILabel = .init()
    let goalNavigationButton: UIButton = .init()
    
    let goalDateView = FootprintGoalView(goalType: .date, userGoal: "매주 화,목,토")
    let goalTimeView = FootprintGoalView(goalType: .time, userGoal: "하루 30분")
    let goalTimeZoneView = FootprintGoalView(goalType: .timeZone, userGoal: "이른 오전")
    let goalStackView: UIStackView = .init()
    
    // MARK: - tab
    let tabUnderlineView = UnderLineView()
    let dayAchievementTabButton = TabButton(.dayAchievement)
    let monthRecordTabButton = TabButton(.monthRecord)
    let monthAchievementTabButton = TabButton(.monthAchievement)
    var selectedTab: TabItem = .dayAchievement {
        didSet {
            indexBind(oldValue: oldValue.index, newValue: selectedTab.index)
        }
    }
    
    let tabStackView: UIStackView = .init()
    let test1VC = DayAchievementViewController()
    let test2VC = MonthAchievementViewController()
    let test3VC = Test3VC()
    
    lazy var tabViews: [UIViewController] = [test1VC, test2VC, test3VC]
    lazy var tabPageVC: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return vc
    }()
    
    
    let testView: UIView = .init()
    
// MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        tabSelected(selectedTab)
        tabBind()
        
        tabPageVC.delegate = self
        tabPageVC.dataSource = self
        
        if let firstVC = tabViews.first {
            tabPageVC.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
// MARK: - setupProperty
    override func setupProperty() {
        super.setupProperty()
        
        myFootprintLabel.text = "마이페이지"
        myFootprintLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        myFootprintLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        settingButton.setImage(UIImage(named: FootprintIOSAsset.Images.settingsIcon.name), for: .normal)
        
        underlineView.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        // MARK: - topInfo
        userBagdeImageView.image = FootprintIOSAsset.Images.myFootbadge.image
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 8
        userNameLabel.attributedText = NSMutableAttributedString()
            .bold(string: "닉네임 ", fontSize: 16)
            .regular(string: "님", fontSize: 16)

        userRepresentNicknameLabel.text = "발자국 스타터"
        userRepresentNicknameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        moreButton.setImage(FootprintIOSAsset.Images.backIcon.image, for: .normal)
        
        // MARK: - middleSummary
        todayChartLabel.text = "오늘 달성률"
        monthChartLabel.text = "이번 달 달성률"
        monthFootprintLabel.text = "이번 달 산책횟수"
        monthFootprintCountLabel.text = "20회"
        
        monthFootprintCountLabel.font = .systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 700))
        monthFootprintCountLabel.textColor = FootprintIOSAsset.Colors.yellowM.color
        
        [todayChartLabel, monthChartLabel, monthFootprintLabel].forEach {
            $0.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 300))
            $0.textColor = FootprintIOSAsset.Colors.blackL.color
        }
        
        middleSummaryStackView.axis = .horizontal
        middleSummaryStackView.distribution = .equalSpacing
        
        [todayChartStackView, monthChartStackView, monthFootprintCountStackView].forEach {
            $0.axis = .vertical
            $0.alignment = .center
        }
        
        // MARK: - 산책 목표
        goalNavigationLabel.text = "산책 목표"
        goalNavigationLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 700))
        goalNavigationLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        goalNavigationButton.setImage(FootprintIOSAsset.Images.backIcon.image, for: .normal)
        
        goalStackView.axis = .vertical
        goalStackView.spacing = 0
        
        // MARK: - 달성률 탭바
        tabStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.layoutMargins = UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20)
            $0.isLayoutMarginsRelativeArrangement = true
        }
        
        testView.backgroundColor = .blue
    }
    
// MARK: - setupLayout
    override func setupLayout() {
        super.setupLayout()
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        myFootprintLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        myFootprintScrollView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        topInfoView.snp.makeConstraints {
            $0.left.right.equalTo(self.view)
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        }
        
        userBagdeImageView.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }
        
        userNameStackView.snp.makeConstraints {
            $0.leading.equalTo(userBagdeImageView.snp.trailing).offset(9)
            $0.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(topInfoView.snp.trailing).inset(16)
        }
        
        // MARK: - middleSummary
        [todayChartView, monthChartView, monthFootprintView].forEach {
            $0.snp.makeConstraints {
                $0.width.height.equalTo(100)
            }
        }
        
        monthFootprintCountLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        middleSummaryStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topInfoView.snp.bottom)
            $0.height.equalTo(130)
            $0.width.equalTo(320)
        }
        
        // MARK: - 산책 목표
        goalUnderlineView.snp.makeConstraints {
            $0.width.equalTo(self.view)
            $0.height.equalTo(8)
            $0.top.equalTo(middleSummaryStackView.snp.bottom).offset(10)
        }
        
        goalNavigationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        goalNavigationButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        
        goalNavigationView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(self.view)
            $0.top.equalTo(goalUnderlineView.snp.bottom).offset(10)
        }
        
        [goalDateView, goalTimeView, goalTimeZoneView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(325)
                $0.height.equalTo(50)
            }
        }
        
        goalStackView.snp.makeConstraints {
            $0.top.equalTo(goalNavigationView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        // MARK: - 달성률 탭바
        tabUnderlineView.snp.makeConstraints {
            $0.width.equalTo(self.view)
            $0.height.equalTo(8)
            $0.top.equalTo(goalStackView.snp.bottom).offset(10)
        }
        
        tabStackView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(tabUnderlineView.snp.bottom).offset(5)
        }
        
        tabPageVC.view.snp.makeConstraints {
            $0.top.equalTo(tabStackView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        
        tabPageVC.didMove(toParent: self)
        
        // MARK: - test
        testView.snp.makeConstraints {
            $0.top.equalTo(tabPageVC.view.snp.bottom).offset(10)
            $0.width.equalTo(self.view)
            $0.height.equalTo(400)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
// MARK: - setupHierarchy
    override func setupHierarchy() {
        super.setupHierarchy()
        
        navigationView.addSubviews([myFootprintLabel, settingButton])
        
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userRepresentNicknameLabel)
        topInfoView.addSubviews([userBagdeImageView, userNameStackView, moreButton])
        monthFootprintView.addSubview(monthFootprintCountLabel)
        
        [todayChartView, todayChartLabel].forEach {
            todayChartStackView.addArrangedSubview($0)
        }
        
        [monthChartView, monthChartLabel].forEach {
            monthChartStackView.addArrangedSubview($0)
        }
        
        [monthFootprintView, monthFootprintLabel].forEach {
            monthFootprintCountStackView.addArrangedSubview($0)
        }
        
        [todayChartStackView, monthChartStackView, monthFootprintCountStackView].forEach {
            middleSummaryStackView.addArrangedSubview($0)
        }
        
        [goalDateView, goalTimeView, goalTimeZoneView].forEach {
            goalStackView.addArrangedSubview($0)
        }
        
        goalNavigationView.addSubviews([goalNavigationLabel, goalNavigationButton])
        
        [dayAchievementTabButton, monthRecordTabButton, monthAchievementTabButton].forEach {
            tabStackView.addArrangedSubview($0)
        }
        
        addChild(tabPageVC) // 추가됨
        
        myFootprintScrollView.addSubviews([topInfoView, middleSummaryStackView, goalUnderlineView, goalNavigationView, goalStackView, tabUnderlineView, tabStackView, tabPageVC.view, testView])
        view.addSubviews([navigationView, underlineView, myFootprintScrollView])
    }
}

// MARK: - 달성률 탭바
class TabButton: UIButton {
    let bottomLineView: UIView = .init()
    
    override var isSelected: Bool {
        didSet {
            bottomLineView.isHidden = !isSelected
        }
    }
    
    init(_ type: MyFootprintViewController.TabItem) {
        super.init(frame: .zero)
        setTitle(type.text, for: .normal)
        setTitle(type.text, for: .selected)
        setupProperty()
        setupLayout()
    }
    
    private func setupProperty() {
        setTitleColor(FootprintIOSAsset.Colors.whiteD.color, for: .normal)
        setTitleColor(FootprintIOSAsset.Colors.blueM.color, for: .selected)
        titleLabel?.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 500))
        configuration?.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 10,
            bottom: 8,
            trailing: 10
        )
        bottomLineView.backgroundColor = FootprintIOSAsset.Colors.blueM.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(2)
        }
    }
}

extension MyFootprintViewController {
    private func tabSelected(_ type: TabItem) {
        switch type {
        case .dayAchievement:
            selectedTabButton(true, false, false)
        case .monthRecord:
            selectedTabButton(false, true, false)
        case .monthAchievement:
            selectedTabButton(false, false, true)
        }
        self.selectedTab = type
    }
    
    private func selectedTabButton(_ day: Bool, _ monthRecord: Bool, _ month: Bool) {
        dayAchievementTabButton.isSelected = day
        monthRecordTabButton.isSelected = monthRecord
        monthAchievementTabButton.isSelected = month
    }
    
    private func tabBind() {
        Observable.merge(
            dayAchievementTabButton.rx.tap.map { _ -> TabItem in return .dayAchievement },
            monthRecordTabButton.rx.tap.map { _ -> TabItem in return .monthRecord },
            monthAchievementTabButton.rx.tap.map { _ -> TabItem in return .monthAchievement }
        ).subscribe { [weak self] tabItem in
            guard tabItem == self?.selectedTab else {
                self?.tabSelected(tabItem)
                return
            }
        }
        .disposed(by: disposeBag)
    }
}

extension MyFootprintViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = tabViews.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return tabViews[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = tabViews.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == tabViews.count {
            return nil
        }
        return tabViews[nextIndex]
    }
    
    private func indexBind(oldValue: Int, newValue: Int) {
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        tabPageVC.setViewControllers([tabViews[selectedTab.index]], direction: direction, animated: true, completion: nil)
        
        let tabCase = TabItem.allCases.filter { return $0.index == newValue }
        switch tabCase[0] {
        case .dayAchievement:
            selectedTabButton(true, false, false)
        case .monthRecord:
            selectedTabButton(false, true, false)
        case .monthAchievement:
            selectedTabButton(false, false, true)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard let currentVC = tabPageVC.viewControllers?.first,
                  let currentIndex = tabViews.firstIndex(of: currentVC) else { return }
        
        let tabCase = TabItem.allCases.filter { return $0.index == currentIndex }
        selectedTab = tabCase[0]
    }
}
