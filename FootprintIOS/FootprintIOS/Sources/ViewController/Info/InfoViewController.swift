//
//  InfoViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import Then

class InfoViewController: NavigationBarViewController, View {
    
    // MARK: - Properties
    
    typealias Reactor = InfoReactor
    
    // MARK: - UI Components
    
    private let infoScrollView: UIScrollView = .init()
    private let infoContentView: UIView = .init()
    
    private let selectedPageCircle = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueM.color
        $0.layer.cornerRadius = 7
    }
    
    private let pageNumLabel = UILabel().then {
        $0.text = "1"
        $0.font = .systemFont(ofSize: 11, weight: .semibold)
        $0.textColor = .white
    }
    
    private let unSelectedPageCircle = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white3.color
        $0.layer.cornerRadius = 3
    }
    
    private let pageStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "정보를 입력해 주세요"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
        $0.textColor = .black
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "정보를 입력하면 더 정확한 서비스를 제공받을 수 있어요"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임*"
    }
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해 주세요 (최대 8자)"
    }
    
    private let nicknameTFlineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.grayL.color
    }
    
    private let heightTFlineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueL.color
    }
    
    private let weightTFlineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueL.color
    }
    
    private let genderLabel = UILabel().then {
        $0.text = "성별*"
    }
    
    private let genderSegmentControl = UISegmentedControl(items: ["여", "남", "선택안함"]).then {
        $0.layer.cornerRadius = 15
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let birthLabel = UILabel().then {
        $0.text = "생년월일"
    }
    
    private let birthDatePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
    }
    
    private let bodyLabel = UILabel().then {
        $0.text = "키/몸무게"
    }
    
    private lazy var bodyInfoButton = UIButton().then {
        $0.setImage(FootprintIOSAsset.Images.bodyInfoButtonIcon.image, for: .normal)
    }
    
    private let bodyInfoImageView = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.bodyInfoImage.image
        $0.isHidden = true
    }
    
    private let bodyInfoLabel = UILabel().then {
        $0.text = "칼로리 계산에 이용돼요!\n(미입력시 부정확할 수 있어요)"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textAlignment = .center
    }
    
    private let bodyInfoStackView = UIStackView().then {
        $0.spacing = 40
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let heightLabel = UILabel().then {
        $0.text = "cm"
        $0.textColor = FootprintIOSAsset.Colors.blueL.color
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let heightTextField = UITextField().then {
        $0.placeholder = "170"
    }
    
    private let weightLabel = UILabel().then {
        $0.text = "kg"
        $0.textColor = FootprintIOSAsset.Colors.blueL.color
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let weightTextField = UITextField().then {
        $0.placeholder = "50"
    }
    
    private lazy var bottomButton: UIButton = FootprintButton.init(type: .next)
    
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
        
        pageStackView.addArrangedSubview(selectedPageCircle)
        pageStackView.addArrangedSubview(unSelectedPageCircle)
        
        [nicknameLabel, genderLabel, birthLabel, bodyLabel].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        
        [nicknameTextField, heightTextField, weightTextField].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14)
        }
        
        heightTextField.rightView = heightLabel
        weightTextField.rightView = weightLabel
        heightTextField.rightViewMode = .always
        weightTextField.rightViewMode = .always
        
        bodyInfoStackView.addArrangedSubview(heightTextField)
        bodyInfoStackView.addArrangedSubview(weightTextField)
    }

    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        selectedPageCircle.addSubview(pageNumLabel)
        view.addSubviews([infoScrollView, pageStackView, titleLabel, subtitleLabel,
                          bottomButton])
        infoScrollView.addSubview(infoContentView)
        bodyInfoImageView.addSubview(bodyInfoLabel)
        infoContentView.addSubviews([nicknameLabel, nicknameTextField, nicknameTFlineView, genderLabel,
                                     genderSegmentControl, lineView, birthLabel, birthDatePicker,
                                     bodyLabel, bodyInfoButton, bodyInfoImageView, bodyInfoStackView,
                                     heightTFlineView, weightTFlineView])
    }

    
    override func setupLayout() {
        super.setupLayout()
        
        selectedPageCircle.snp.makeConstraints {
            $0.height.width.equalTo(14)
        }
        
        pageNumLabel.snp.makeConstraints {
            $0.center.equalTo(selectedPageCircle)
        }
        
        unSelectedPageCircle.snp.makeConstraints {
            $0.height.width.equalTo(6)
        }
        
        pageStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(pageStackView.snp.bottom).offset(34)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        infoScrollView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        infoContentView.snp.makeConstraints {
            $0.edges.equalTo(infoScrollView)
            $0.width.equalTo(infoScrollView.snp.width)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(infoContentView.snp.top).offset(10)
            $0.leading.equalToSuperview().inset(34)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
        
        nicknameTFlineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(nicknameTextField)
            $0.height.equalTo(1)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTFlineView.snp.bottom).offset(40)
            $0.leading.equalTo(nicknameLabel)
        }
        
        genderSegmentControl.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(genderSegmentControl.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(7)
        }
        
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.top).offset(40)
            $0.leading.equalTo(nicknameLabel)
        }
        
        birthDatePicker.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(40)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(birthDatePicker.snp.bottom).offset(40)
            $0.leading.equalTo(nicknameLabel)
        }
        
        bodyInfoButton.snp.makeConstraints {
            $0.leading.equalTo(bodyLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(15)
            $0.centerY.equalTo(bodyLabel)
        }
        
        bodyInfoImageView.snp.makeConstraints {
            $0.bottom.equalTo(bodyInfoButton.snp.top).offset(-3)
            $0.leading.equalToSuperview().inset(75)
            $0.height.equalTo(53)
            $0.width.equalTo(205)
        }
        
        bodyInfoLabel.snp.makeConstraints {
            $0.top.equalTo(bodyInfoImageView).inset(6)
            $0.centerX.equalTo(bodyInfoImageView)
        }
        
        heightTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        heightTFlineView.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom)
            $0.leading.trailing.equalTo(heightTextField)
            $0.height.equalTo(1)
        }
        
        weightTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        weightTFlineView.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom)
            $0.leading.trailing.equalTo(weightTextField)
            $0.height.equalTo(1)
        }
        
        bodyInfoStackView.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(infoContentView.snp.bottom).inset(150)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(70)
        }
    }

    
    func bind(reactor: InfoReactor) {
        // Action
        bottomButton
            .rx
            .tap
            .map { .tapBottomButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map(\.isPresent)
            .filter { $0 }
            .bind { [weak self] _ in
                let goalViewController = GoalViewController(reactor: .init())
                self?.navigationController?.pushViewController(goalViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
