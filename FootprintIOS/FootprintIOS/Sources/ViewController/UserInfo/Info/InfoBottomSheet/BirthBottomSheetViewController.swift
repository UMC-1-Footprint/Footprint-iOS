//
//  BirthBottomSheetViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import Then

final class BirthBottomSheetViewController: BottomSheetViewController, View {
    
    typealias Reactor = BirthBottomSheetReactor
    
    // MARK: - UI Components
    
    private let contentView = UIView.init()
    
    private let titleLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(FootprintIOSAsset.Colors.blueM.color, for: .normal)
    }
    
    private var datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
    }
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(type: .fix)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([titleLabel, completeButton, datePicker])
        
        addContentView(view: contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(110)
        }
    }
    
    // MARK: - Methods
    
    func bind(reactor: BirthBottomSheetReactor) {
        completeButton.rx.tap
            .withUnretained(self)
            .map { (owner, _) -> String in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                let birth = dateFormatter.string(from: owner.datePicker.date)
                return birth
            }
            .map { .tapDoneButton($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.dismiss)
            .withUnretained(self)
            .bind { (owner, _) in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
