//
//  InfoViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import RxGesture
import Then

enum GenderType: Int {
    case female
    case male
    case none
    
    var genderType: String {
        switch self {
        case .female:
            return "female"
        case .male:
            return "male"
        case .none:
            return "none"
        }
    }
}

class InfoViewController: NavigationBarViewController, View {
    
    typealias Reactor = InfoReactor

    // MARK: - Properties
    
    var pushGoalScreen: () -> GoalViewController
    
    
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
    
    private let nicknameLabel = UserInfoLabel(title: "닉네임*")
    private let genderLabel = UserInfoLabel(title: "성별*")
    private let birthLabel = UserInfoLabel(title: "생년월일")
    private let bodyLabel = UserInfoLabel(title: "키/몸무게")
    
    private let nicknameTextField = InfoTextField(type: .nickname)
    private let heightTextField = InfoTextField(type: .height)
    private let weightTextField = InfoTextField(type: .weight)
    
    private let genderSegmentControl = UISegmentedControl(items: ["여자", "남자", "선택안함"]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color.withAlphaComponent(0.5)
        $0.selectedSegmentTintColor = FootprintIOSAsset.Colors.blueM.color
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .selected)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : FootprintIOSAsset.Colors.blackL.color, .font: UIFont.systemFont(ofSize: 12)], for: .normal)
        $0.layer.cornerRadius = 15
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let birthSelectView = UserInfoSelectBar(type: .birth)
    
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
        $0.spacing = 10
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let heightLabel = UILabel().then {
        $0.text = "cm"
    }
    
    private let weightLabel = UILabel().then {
        $0.text = "kg"
    }
    
    
    private lazy var bottomButton: UIButton = FootprintButton.init(type: .next)
    
    // MARK: - Initializer
    
    init(reactor: Reactor,
         pushGoalScreen: @escaping () -> GoalViewController) {
        self.pushGoalScreen = pushGoalScreen
        
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        
        hideKeyboard()
        setKeyboardNotification()
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
        
        [nicknameTextField, heightTextField, weightTextField].forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14)
        }
        
        [heightLabel, weightLabel].forEach {
            $0.textColor = FootprintIOSAsset.Colors.blackL.color
            $0.font = .systemFont(ofSize: 14)
        }
        
        bodyInfoStackView.addArrangedSubviews(heightTextField, heightLabel, weightTextField, weightLabel)
    }
    
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        selectedPageCircle.addSubview(pageNumLabel)
        view.addSubviews([infoScrollView, pageStackView, bottomButton])
        infoScrollView.addSubview(infoContentView)
        bodyInfoImageView.addSubview(bodyInfoLabel)
        infoContentView.addSubviews([titleLabel, subtitleLabel, nicknameLabel, nicknameTextField,
                                     genderLabel, genderSegmentControl,lineView, birthLabel,
                                     birthSelectView, bodyLabel,bodyInfoButton, bodyInfoImageView,
                                     bodyInfoStackView])
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
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.centerX.equalToSuperview()
        }
        
        infoScrollView.snp.makeConstraints {
            $0.top.equalTo(pageStackView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        infoContentView.snp.makeConstraints {
            $0.edges.equalTo(infoScrollView)
            $0.width.equalTo(infoScrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(infoContentView.snp.top)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.leading.equalTo(titleLabel)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(40)
            $0.leading.equalTo(nicknameLabel)
        }
        
        genderSegmentControl.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(34)
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
        
        birthSelectView.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(34)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(birthSelectView.snp.bottom).offset(40)
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
        
        [heightTextField, weightTextField].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(40)
                $0.width.equalTo(120)
            }
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
        bottomButton.rx.tap
            .withUnretained(self)
            .map { (this, _) -> InfoModel in
                let idx = this.genderSegmentControl.selectedSegmentIndex
                let gender = GenderType(rawValue: idx)?.genderType
                let info = InfoModel(nickname: this.nicknameTextField.text ?? "",
                                     sex: gender ?? "none",
                                     birth: "1999-12-20",
                                     height: Int(this.heightTextField.text ?? "0") ?? 0,
                                     weight: Int(this.weightTextField.text ?? "0") ?? 0)
                return info
            }
            .map { .tapDoneButton($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        birthSelectView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { this, _ in
                let reactor = BirthBottomSheetReactor.init(state: .init())
                let birthBottomSheet = BirthBottomSheetViewController(reactor: reactor)
                this.present(birthBottomSheet, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap(\.userInfo)
            .withUnretained(self)
            .bind { (this, info) in
                this.goToGoalScreen()
                // infoModel을 goalVC.~ 프로퍼티로 넘겨줌
                print(info)
            }
            .disposed(by: disposeBag)
    }
    
    override func keyboardWillShow(height: CGFloat) {
        super.keyboardWillShow(height: height)
        
        if !nicknameTextField.isEditing {
            view.window?.frame.origin.y = -(height - 150)
        }
    }
    
    override func keyboardWillHide() {
        super.keyboardWillHide()
        
        if !nicknameTextField.isEditing {
            view.window?.frame.origin.y = 0
        }
    }
    
    private func goToGoalScreen() {
        let controller = self.pushGoalScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
