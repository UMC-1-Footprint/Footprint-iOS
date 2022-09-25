//
//  LoginViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxSwift
import KakaoSDKUser

enum LoginButtonType {
    case google
    case kakao
    
    var title: String {
        switch self {
        case .kakao:
            return "  카카오계정으로 로그인"
        case .google:
            return " 구글계정으로 로그인"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .kakao:
            return FootprintIOSAsset.Images.kakaoIcon.image
        case .google:
            return FootprintIOSAsset.Images.googleIcon.image
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .kakao:
            return FootprintIOSAsset.Colors.yellowM.color
        case .google:
            return .white
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .kakao:
            return FootprintIOSAsset.Colors.yellowM.color
        case .google:
            return FootprintIOSAsset.Colors.blueM.color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .kakao, .google:
            return FootprintIOSAsset.Colors.blackD.color
        }
    }
}

class LoginButton: UIButton {
    let type: LoginButtonType
    
    init(type: LoginButtonType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setTitle(type.title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 700))
        setImage(type.icon, for: .normal)
        setTitleColor(type.textColor, for: .normal)
        backgroundColor = type.backgroundColor
        self.layer.borderWidth = 1
        self.layer.borderColor = type.borderColor.cgColor
        cornerRound(radius: 24)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginViewController: NavigationBarViewController {
    // MARK: - properties
    let loginBackgroundImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.road.image
    }
    
    let subtitle = UILabel().then {
        $0.text = "길위에 남기는 나만의 기록"
        $0.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        $0.textColor = FootprintIOSAsset.Colors.blueM.color
    }
    
    let footLogoImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.footBigLogo.image
    }
    
    let logoImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.footprintBigLogo.image
    }
    
    let legacyLabel = UILabel().then {
        $0.text = "ⓒ 2022. 발자국 all rights reserved."
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    let laterLoginButton = UIButton().then {
        $0.setTitle("나중에 로그인할래요", for: .normal)
        $0.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 400))
    }
    
    let googleLoginButton = LoginButton(type: .google)
    let kakaoLoginButton = LoginButton(type: .kakao)
    
    // MARK: - bind
    override func setupBind() {
        super.setupBind()
        
        kakaoLoginButton.rx
            .tap
            .bind { _ in
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    self.kakaoLoginApp()
                }
                else {
                    self.kakaoLoginWeb()
                }
            }
            .disposed(by: disposeBag)
            
    }
    
    // MARK: - set
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([loginBackgroundImage, subtitle, footLogoImage, logoImage])
        contentView.addSubviews([legacyLabel, laterLoginButton, googleLoginButton, kakaoLoginButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        loginBackgroundImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
            $0.height.equalTo(303)
        }
        
        subtitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(67)
        }
        
        footLogoImage.snp.makeConstraints {
            $0.top.equalTo(subtitle.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(footLogoImage.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        legacyLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(55)
            $0.centerX.equalToSuperview()
        }
        
        laterLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(legacyLabel.snp.top).offset(-44)
            $0.centerX.equalToSuperview()
        }

        googleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(laterLoginButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(37)
            $0.height.equalTo(48)
        }

        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(googleLoginButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(37)
            $0.height.equalTo(48)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("로그인")
        setNavigationBarBackgroundColor(.white)
        setNavigationBarBackButtonImage(.backButtonIcon)
        setNavigationBarTitleFont(.boldSystemFont(ofSize: 16))
    }
}

// MARK: - extension
extension LoginViewController {
    func kakaoLoginApp() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")

                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        // TODO: - 로그인 성공한 경우. 뷰컨 이동하기
                        print(user)
                    }
                }
            }
        }
    }
    
    func kakaoLoginWeb() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    UserApi.shared.me {(user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            // TODO: - 로그인 성공한 경우. 뷰컨 이동하기
                            print(user)
                        }
                    }
                }
            }
    }
}
