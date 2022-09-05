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
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([badgePageButton, loginPageButton, agreementPageButton])
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
    }
    
    override func setupBind() {
        super.setupBind()
        
        badgePageButton.rx
            .tap
            .bind { [weak self] _ in
                let badgeViewController = BadgeViewController()
                
                self?.navigationController?.pushViewController(badgeViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        loginPageButton.rx
            .tap
            .bind { [weak self] _ in
                let loginViewController = LoginViewController()
                
                self?.navigationController?.pushViewController(loginViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        agreementPageButton.rx
            .tap
            .bind { [weak self] _ in
                let agreementViewController = AgreementViewController(reactor: .init())
                
                self?.navigationController?.pushViewController(agreementViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
