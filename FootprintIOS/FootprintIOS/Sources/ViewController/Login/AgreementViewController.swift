//
//  AgreementViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import ReactorKit

enum agreementType {
    case first
    case second
    case third
    case fourth
    case final
    
    var title: String {
        switch self {
        case .first:
            return "이용약관 (필수)"
        case .second:
            return "위치서비스 이용약관 (필수)"
        case .third:
            return "개인정보 수집 이용 (필수)"
        case .fourth:
            return "앱 푸시 알림 수신 동의 (선택)"
        case .final:
            return "모두 동의합니다"
        }
    }
    
    var button: Bool {
        switch self {
        case .first, .second, .third:
            return true
        case .fourth, .final:
            return false
        }
    }
}

class agreementView: UIView {
    let type: agreementType
    var checkboxButton: UIButton = .init()
    lazy var moreButton: UIButton = .init()
    lazy var titleLabel = UILabel().then {
        $0.text = type.title
        $0.font = .systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 500))
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    
    init(type: agreementType) {
        self.type = type
        
        super.init(frame: .zero)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {
        moreButton.setImage(FootprintIOSAsset.Images.moreIcon.image, for: .normal)
        checkboxButton.setImage(FootprintIOSAsset.Images.checkboxOff.image, for: .normal)
        checkboxButton.setImage(FootprintIOSAsset.Images.checkboxOn.image, for: .selected)
        moreButton.isHidden = !type.button
    }
    
    func setupHierarchy() {
        addSubviews([checkboxButton, titleLabel, moreButton])
    }
    
    func setupLayout() {
        checkboxButton.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkboxButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(6)
            $0.height.equalTo(12)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupBind() { }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AgreementViewController: NavigationBarViewController, View {
    
    typealias Reactor = AgreementReactor
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let noteImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.notePencil.image
    }
    
    let noticeLabel = UILabel().then {
        $0.text = "서비스 이용을 위해서 약관 동의가 필요해요"
        $0.font = .systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 400))
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    let firstAgreement = agreementView(type: .first)
    let secondAgreement = agreementView(type: .second)
    let thirdAgreement = agreementView(type: .third)
    let fourthAgreement = agreementView(type: .fourth)
    let finalAgreement = agreementView(type: .final)
    
    let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
    }
    
    let confirmButton = FootprintButton(type: .confirm)
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("약관 동의")
        setNavigationBarBackgroundColor(.white)
        setNavigationBarBackButtonImage(.backButtonIcon)
        setNavigationBarTitleFont(.boldSystemFont(ofSize: 16))
    }
    
    func bind(reactor: AgreementReactor) {
        firstAgreement.checkboxButton
            .rx
            .tap
            .map { .selectButton(.first) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        secondAgreement.checkboxButton
            .rx
            .tap
            .map { .selectButton(.second) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        thirdAgreement.checkboxButton
            .rx
            .tap
            .map { .selectButton(.third) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        fourthAgreement.checkboxButton
            .rx
            .tap
            .map { .selectButton(.fourth) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedFirstButton)
            .bind(to: firstAgreement.checkboxButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedSecondButton)
            .bind(to: secondAgreement.checkboxButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedThirdButton)
            .bind(to: thirdAgreement.checkboxButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.isSelectedFourthButton)
            .bind(to: fourthAgreement.checkboxButton.rx.isSelected)
            .disposed(by: disposeBag)
    }

    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([noteImage, noticeLabel, firstAgreement, secondAgreement, thirdAgreement, fourthAgreement, lineView, finalAgreement, confirmButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        noteImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(35)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noteImage.snp.bottom).offset(45)
        }
        
        firstAgreement.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        secondAgreement.snp.makeConstraints {
            $0.top.equalTo(firstAgreement.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        thirdAgreement.snp.makeConstraints {
            $0.top.equalTo(secondAgreement.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        fourthAgreement.snp.makeConstraints {
            $0.top.equalTo(thirdAgreement.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(fourthAgreement.snp.bottom).offset(12)
            $0.height.equalTo(1)
        }
        
        finalAgreement.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(56)
            $0.height.equalTo(56)
        }
    }
}
