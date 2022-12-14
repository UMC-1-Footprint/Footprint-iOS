//
//  MyPageViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/29.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift

class MyPageViewController: NavigationBarViewController {
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("마이페이지")
    }
    
    let badgePageButton = UIButton().then {
        $0.setTitle("뱃지 뷰컨으로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let loginPageButton = UIButton().then {
        $0.setTitle("로그인 뷰컨으로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let agreementPageButton = UIButton().then {
        $0.setTitle("약관동의 뷰컨으로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let myFootprintButton = UIButton().then {
        $0.setTitle("내 발자국 페이지로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    let walkScreenButton = UIButton().then {
        $0.setTitle("산책 기록 페이지로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    var pushMyFootprintScreen: () -> MyFootprintViewController
    var pushWalkRecordScreen: () -> WalkRecordViewController
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([badgePageButton, loginPageButton, agreementPageButton, myFootprintButton, walkScreenButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        badgePageButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        loginPageButton.snp.makeConstraints {
            $0.top.equalTo(badgePageButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        agreementPageButton.snp.makeConstraints {
            $0.top.equalTo(loginPageButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        myFootprintButton.snp.makeConstraints {
            $0.top.equalTo(agreementPageButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        walkScreenButton.snp.makeConstraints {
            $0.top.equalTo(myFootprintButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Initializer
    init(pushMyFootprintScreen: @escaping () -> MyFootprintViewController, pushWalkRecordScreen: @escaping () -> WalkRecordViewController) {
        self.pushMyFootprintScreen = pushMyFootprintScreen
        self.pushWalkRecordScreen = pushWalkRecordScreen
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupBind() {
        super.setupBind()
        
        badgePageButton.rx
            .tap
            .bind { [weak self] _ in
                let badgeViewController = BadgeViewController()
                badgeViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(badgeViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        loginPageButton.rx
            .tap
            .bind { [weak self] _ in
                let loginViewController = LoginViewController(reactor: .init(loginService: LoginService(), keychainService: KeychainService()))
                loginViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(loginViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        agreementPageButton.rx
            .tap
            .bind { [weak self] _ in
                let agreementViewController = AgreementViewController(reactor: .init())
                agreementViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(agreementViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        myFootprintButton.rx
            .tap
            .bind { [weak self] _ in
                self?.willPushMyFootprintScreen()
            }
            .disposed(by: disposeBag)
        
        walkScreenButton.rx
            .tap
            .bind { [weak self] _ in
                self?.willPushWalkRecordScreen()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    private func willPushMyFootprintScreen() {
        let controller = self.pushMyFootprintScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func willPushWalkRecordScreen() {
        let controller = self.pushWalkRecordScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
