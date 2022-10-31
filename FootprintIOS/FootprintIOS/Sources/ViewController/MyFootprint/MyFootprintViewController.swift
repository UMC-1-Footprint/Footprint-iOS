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
    
    let testView: UIView = .init()
 
    override func setupProperty() {
        super.setupProperty()
        
        myFootprintLabel.text = "마이페이지"
        myFootprintLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        myFootprintLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        settingButton.setImage(UIImage(named: FootprintIOSAsset.Images.settingsIcon.name), for: .normal)
        
        underlineView.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        userBagdeImageView.image = FootprintIOSAsset.Images.myFootbadge.image
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 8
        userNameLabel.attributedText = NSMutableAttributedString()
            .bold(string: "닉네임 ", fontSize: 16)
            .regular(string: "님", fontSize: 16)

        userRepresentNicknameLabel.text = "발자국 스타터"
        userRepresentNicknameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        moreButton.setImage(FootprintIOSAsset.Images.backIcon.image, for: .normal)
        
        testView.backgroundColor = .blue
    }
    
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
        
        testView.snp.makeConstraints {
            $0.top.equalTo(topInfoView.snp.bottom).offset(10)
            $0.width.equalTo(self.view)
            $0.height.equalTo(800)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        navigationView.addSubviews([myFootprintLabel, settingButton])
        
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userRepresentNicknameLabel)
        topInfoView.addSubviews([userBagdeImageView, userNameStackView, moreButton])
        
        myFootprintScrollView.addSubviews([topInfoView, testView])
        view.addSubviews([navigationView, underlineView, myFootprintScrollView])
    }
}
