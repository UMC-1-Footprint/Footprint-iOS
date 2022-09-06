//
//  AlertViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import Then

enum AlertType {
    case noGoal
    case changeGoal
    case delete
    case save
    case cancel
    case setBadge
    case logout
    case withdrawal
    case deleteAll
    case badge
    case custom
    
    var title: String {
        switch self {
        case .noGoal:
            return "변경된 목표가 없어요"
        case .changeGoal:
            return "다음달 목표를 변경했어요"
        case .delete:
            return "해당 발자국을 삭제할까요?"
        case .save:
            return "번째 산책'을 저장할까요?"
        case .cancel:
            return "번째 산책'작성을 취소할까요?"
        case .setBadge:
            return "대표뱃지로 설정할까요?"
        case .logout:
            return "발자국에서 로그아웃하시겠어요?"
        case .withdrawal:
            return "정말 발자국을 탈퇴하시겠어요?"
        case .deleteAll:
            return "번째 산책'을 삭제하시겠어요?"
        case .badge:
            return "'Start'\n뱃지를 획득했어요!"
        case .custom:
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
    typealias Reactor = AlertReactor
    
    // MARK: - UI Components
    
    private lazy var oneButtonAlertView = OneButtonAlertView.init(type: self.type)
    private lazy var twoButtonAlertView = TwoButtonAlertView.init(type: self.type)
    private lazy var badgeAlertView = BadgeAlertView.init(type: self.type)
    private lazy var customAlertView = CustomAlertView.init(type: self.type)
    
    // MARK: - Initializer
    
    init(type: AlertType) {
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .white.withAlphaComponent(0.4)
        
        switch type {
        case .noGoal, .changeGoal:
            oneButtonAlertView.isHidden = false
        case .delete, .save, .cancel, .setBadge, .logout, .withdrawal, .deleteAll:
            twoButtonAlertView.isHidden = false
        case .badge:
            badgeAlertView.isHidden = false
        case .custom:
            customAlertView.isHidden = false
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([oneButtonAlertView, twoButtonAlertView, badgeAlertView, customAlertView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [oneButtonAlertView, twoButtonAlertView, badgeAlertView, customAlertView].forEach {
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    
    func bind(reactor: AlertReactor) {
        // Action
        // State
    }
}
