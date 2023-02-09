//
//  AlertViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import Then

enum AlertType {
    case noGoal
    case changeGoal
    case delete
    case save(Int)
    case cancel(Int)
    case setBadge
    case logout
    case withdrawal
    case deleteAll(Int)
    case badge(String)
    case custom(value: Custom)
    
    enum Custom {
        case selectGoalWalkTime
    }
    
    var title: String {
        switch self {
        case .noGoal:
            return "변경된 목표가 없어요"
        case .changeGoal:
            return "다음달 목표를 변경했어요"
        case .delete:
            return "해당 발자국을 삭제할까요?"
        case let .save(i):
            return "\(i)번째 산책'을 저장할까요?"
        case let .cancel(i):
            return "\(i)번째 산책'작성을 취소할까요?"
        case .setBadge:
            return "대표뱃지로 설정할까요?"
        case .logout:
            return "발자국에서 로그아웃하시겠어요?"
        case .withdrawal:
            return "정말 발자국을 탈퇴하시겠어요?"
        case let .deleteAll(i):
            return "\(i)번째 산책'을 삭제하시겠어요?"
        case let .badge(badgeName):
            return "\(badgeName)\n뱃지를 획득했어요!"
        case .custom(value: .selectGoalWalkTime):
            return "목표산책시간 직접설정"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noGoal, .changeGoal, .badge:
            return ""
        case .delete, .cancel, .deleteAll:
            return "삭제"
        case .save:
            return "저장"
        case .setBadge:
            return "설정"
        case .logout:
            return "로그아웃"
        case .withdrawal:
            return "탈퇴하기"
        case .custom:
            return "완료"
        }
    }
    
    var subTitle: String {
        switch self {
        case .noGoal, .changeGoal, .delete, .save, .cancel, .setBadge, .badge, .custom:
            return ""
        case .logout:
            return "*로그인하면 기록을 다시 볼 수 있어요"
        case .withdrawal:
            return "*모든 기록이 삭제되고 복구할 수 없어요"
        case .deleteAll:
            return "*동선을 제외한 발자국이 모두 삭제되고\n해당 기록은 복구할 수 없어요"
        }
    }
}

class AlertViewController: NavigationBarViewController, View {
    
    // MARK: - Properties
    
    private let type: AlertType
    private let customViewType: AlertType.Custom?
    typealias Reactor = AlertReactor
    var alertAction: (() -> Void)?
    var selectTimeAction: ((String) -> Void)?
    
    private lazy var selectedTime: String = ""
    
    // MARK: - UI Components
    
    private lazy var oneButtonAlertView = OneButtonAlertView.init(type: self.type)
    private lazy var twoButtonAlertView = TwoButtonAlertView.init(type: self.type)
    private lazy var badgeAlertView = BadgeAlertView.init(type: self.type)
    private lazy var customAlertView = CustomAlertView.init(type: self.type, customViewType: self.customViewType)
    
    // MARK: - Initializer
    
    init(type: AlertType, customViewType: AlertType.Custom? = nil, reactor: Reactor) {
        self.type = type
        self.customViewType = customViewType
        
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
        
        view.backgroundColor = .black.withAlphaComponent(0.25)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        switch type {
        case .noGoal, .changeGoal:
            view.addSubview(oneButtonAlertView)
        case .delete, .save, .cancel, .setBadge, .logout, .withdrawal, .deleteAll:
            view.addSubview(twoButtonAlertView)
        case .badge:
            view.addSubview(badgeAlertView)
        case .custom:
            view.addSubview(customAlertView)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        switch type {
        case .noGoal, .changeGoal:
            oneButtonAlertView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        case .delete, .save, .cancel, .setBadge, .logout, .withdrawal, .deleteAll:
            twoButtonAlertView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        case .badge:
            badgeAlertView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        case .custom:
            customAlertView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    
    func bind(reactor: AlertReactor) {
        oneButtonAlertView.confirmButton.rx.tap
            .map{ .tapCancelButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        twoButtonAlertView.cancelButton.rx.tap
            .map{ .tapCancelButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        badgeAlertView.confirmButton.rx.tap
            .map{ .tapCancelButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        customAlertView.cancelButton.rx.tap
            .map{ .tapCancelButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        twoButtonAlertView.rightButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { owner, _ in
                owner.alertAction?()
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        if customViewType == .selectGoalWalkTime {
            Observable.combineLatest(
                customAlertView.selectGoalWalkTimeView.selectedHour,
                customAlertView.selectGoalWalkTimeView.selectedMinute
            ).bind { [weak self] (hour, minute) in
                if hour == "4시간" {
                    self?.selectedTime = "4시간"
                    return
                }
                
                let time = hour.contains("0") ? "\(minute)" :
                (minute == "0분") ? "\(hour)" : "\(hour) \(minute)"
                
                self?.selectedTime = time
                if time == "0분" {
                    self?.selectedTime = "10분"
                }
            }
            .disposed(by: disposeBag)
        }
        
        customAlertView.rightButton.rx.tap
            .withUnretained(self)
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { owner, _ in
                if owner.customViewType == .selectGoalWalkTime {
                    owner.selectTimeAction?(owner.selectedTime)
                }
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    
        reactor.state
            .map(\.isDismiss)
            .bind { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension UIViewController {
    func makeAlert(type: AlertType,
                   customViewType: AlertType.Custom? = nil,
                   alertAction: (() -> Void)? = nil,
                   selectTimeAction: ((String) -> Void)? = nil) {
        let alertVC = AlertViewController(type: type, customViewType: customViewType, reactor: .init())
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.alertAction = alertAction
        alertVC.selectTimeAction = selectTimeAction
        self.present(alertVC, animated: true)
    }
}
