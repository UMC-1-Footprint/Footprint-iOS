//
//  InfoView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class InfoView: BaseView {
    
    // MARK: - UI Components
    
    private let infoScrollView: UIScrollView = .init()
    private let infoContentView: UIView = .init()
    
    private let selectedPageCircle: UIView = {
        let view = UIView()
        view.backgroundColor = FootprintIOSAsset.Colors.blueM.color
        view.layer.cornerRadius = 7
        return view
    }()
    
    private let pageNumLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1"
        lb.font = .systemFont(ofSize: 11, weight: .semibold)
        lb.textColor = .white
        return lb
    }()
    
    private let unSelectedPageCircle: UIView = {
        let view = UIView()
        view.backgroundColor = FootprintIOSAsset.Colors.white3.color
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let pageStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 12
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "정보를 입력해 주세요"
        lb.font = .systemFont(ofSize: 24, weight: .semibold)
        lb.textColor = .black
        return lb
    }()
    
    private let subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "정보를 입력하면 더 정확한 서비스를 제공받을 수 있어요"
        lb.font = .systemFont(ofSize: 12)
        lb.textColor = FootprintIOSAsset.Colors.blackL.color
        return lb
    }()
    
    private let nicknameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "닉네임"
        return lb
    }()
    
    private let nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해 주세요 (최대 8자)"
        return tf
    }()
    
    private let nicknameTFlineView: UIView = {
        let view = UIView()
        view.backgroundColor = FootprintIOSAsset.Colors.grayL.color
        return view
    }()
    
    private let heightTFlineView: UIView = {
        let view = UIView()
        view.backgroundColor = FootprintIOSAsset.Colors.blueL.color
        return view
    }()
    
    private let weightTFlineView: UIView = {
        let view = UIView()
        view.backgroundColor = FootprintIOSAsset.Colors.blueL.color
        return view
    }()
    
    private let genderLabel: UILabel = {
        let lb = UILabel()
        lb.text = "성별"
        return lb
    }()
    
    private let genderSegmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["여", "남", "선택안함"])
        sc.layer.cornerRadius = 15
        return sc
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let birthLabel: UILabel = {
        let lb = UILabel()
        lb.text = "생년월일"
        return lb
    }()
    
    private let birthDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        return dp
    }()
    
    private let bodyLabel: UILabel = {
        let lb = UILabel()
        lb.text = "키/몸무게"
        return lb
    }()
    
    private lazy var bodyInfoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(FootprintIOSAsset.Images.bodyInfoButtonIcon.image, for: .normal)
        return btn
    }()
    
    private let bodyInfoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = FootprintIOSAsset.Images.bodyInfoImage.image
        //iv.isHidden = true
        return iv
    }()
    
    private let bodyInfoLabel: UILabel = {
       let lb = UILabel()
        lb.text = "칼로리 계산에 이용돼요!\n(미입력시 부정확할 수 있어요)"
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 12, weight: .medium)
        lb.textAlignment = .center
        return lb
    }()
    
    private let bodyInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 40
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
    }()
    
    private let heightLabel: UILabel = {
        let lb = UILabel()
        lb.text = "cm"
        lb.textColor = FootprintIOSAsset.Colors.blueL.color
        lb.font = .systemFont(ofSize: 16)
        return lb
    }()
    
    private let heightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "170"
        return tf
    }()
    
    private let weightLabel: UILabel = {
        let lb = UILabel()
        lb.text = "kg"
        lb.textColor = FootprintIOSAsset.Colors.blueL.color
        lb.font = .systemFont(ofSize: 16)
        return lb
    }()
    
    private let weightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "50"
        return tf
    }()
    
    private var infoLabels: [UILabel] = .init()
    private var infoTextFields: [UITextField] = .init()
    
    private lazy var bottomButton: UIButton = FootprintButton.init(type: .next)
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
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
        
        infoLabels = [nicknameLabel, genderLabel, birthLabel, bodyLabel]
        infoLabels.forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
        
        infoTextFields = [nicknameTextField, heightTextField, weightTextField]
        infoTextFields.forEach {
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
        addSubviews([infoScrollView, pageStackView, titleLabel, subtitleLabel])
        infoScrollView.addSubview(infoContentView)
        bodyInfoImageView.addSubview(bodyInfoLabel)
        infoContentView.addSubviews([nicknameLabel, nicknameTextField, nicknameTFlineView, genderLabel,
                                     genderSegmentControl, lineView, birthLabel, birthDatePicker,
                                     bodyLabel, bodyInfoButton, bodyInfoImageView, bodyInfoStackView,
                                     heightTFlineView, weightTFlineView, bottomButton])
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
            $0.top.equalToSuperview().inset(40)
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
        }
        
        bottomButton.snp.makeConstraints {
            $0.top.equalTo(bodyInfoStackView.snp.bottom).offset(55)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalTo(infoContentView.snp.bottom)
        }
    }
}
