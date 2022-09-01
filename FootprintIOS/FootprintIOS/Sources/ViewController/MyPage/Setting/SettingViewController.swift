//
//  SettingViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class SettingViewController: NavigationBarViewController {
    
    // MARK: - UI Components
    
    let myInfoMenu: Menu = .init(type: .myInfo)
    let myInfoDivider: UIView = .init()
    let notificationMenu: Menu = .init(type: .notification)
    let notificationDivider: UIView = .init()
    let logoutMenu: Menu = .init(type: .logout)
    let signoutMenu: Menu = .init(type: .signout)
    let signoutDivider: UIView = .init()
    let noticeMenu: Menu = .init(type: .notice)
    let divider: UIView = .init()
    let logo: UIImageView = .init(image: FootprintIOSAsset.Images.iconLogo.image)
    let stackView: UIStackView = .init()
    let privacyButton: UIButton = .init()
    let serviceButton: UIButton = .init()
    let locationButton: UIButton = .init()
    let versionLabel: UILabel = .init()
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("설정")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = FootprintIOSAsset.Colors.white2.color
        
        [myInfoDivider, notificationDivider, signoutDivider, divider].forEach({ $0.backgroundColor = FootprintIOSAsset.Colors.white3.color })
        
        privacyButton.setTitle("개인정보처리방침", for: .normal)
        privacyButton.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 10)
        
        serviceButton.setTitle("이용약관", for: .normal)
        serviceButton.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        serviceButton.titleLabel?.font = .systemFont(ofSize: 10)
        
        locationButton.setTitle("위치서비스이용약관", for: .normal)
        locationButton.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        locationButton.titleLabel?.font = .systemFont(ofSize: 10)
        
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        versionLabel.text = "버전 \(Enviroment.version)\n ⓒ 2022 발자국 all rights reserved."
        versionLabel.numberOfLines = 2
        versionLabel.font = .systemFont(ofSize: 10)
        versionLabel.textColor = UIColor(hex: 0xC3C3C3)
        versionLabel.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([myInfoMenu, myInfoDivider, notificationMenu, notificationDivider, logoutMenu, signoutMenu, signoutDivider, noticeMenu, divider, logo, stackView, versionLabel])
        
        stackView.addArrangedSubview(privacyButton)
        stackView.addArrangedSubview(serviceButton)
        stackView.addArrangedSubview(locationButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        myInfoMenu.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        myInfoDivider.snp.makeConstraints {
            $0.top.equalTo(myInfoMenu.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        notificationMenu.snp.makeConstraints {
            $0.top.equalTo(myInfoDivider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        notificationDivider.snp.makeConstraints {
            $0.top.equalTo(notificationMenu.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        logoutMenu.snp.makeConstraints {
            $0.top.equalTo(notificationDivider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        signoutMenu.snp.makeConstraints {
            $0.top.equalTo(logoutMenu.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        signoutDivider.snp.makeConstraints {
            $0.top.equalTo(signoutMenu.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        noticeMenu.snp.makeConstraints {
            $0.top.equalTo(signoutDivider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        divider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(125)
            $0.height.equalTo(1)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(28)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(32)
        }
        
        versionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
