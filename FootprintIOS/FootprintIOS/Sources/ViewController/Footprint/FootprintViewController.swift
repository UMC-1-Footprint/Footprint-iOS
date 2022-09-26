//
//  FootprintViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/23.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class FootprintViewController: NavigationBarViewController {
    
    let onboardingButton: UIButton = .init()
    let settingButton: UIButton = .init()
    let mapButton: UIButton = .init()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("홈")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        onboardingButton.setTitle("온보딩 버튼", for: .normal)
        onboardingButton.setTitleColor(.black, for: .normal)
        
        settingButton.setTitle("세팅 버튼", for: .normal)
        settingButton.setTitleColor(.black, for: .normal)
        
        mapButton.setTitle("세팅 버튼", for: .normal)
        mapButton.setTitleColor(.black, for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([onboardingButton, settingButton, mapButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        onboardingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.top.equalTo(onboardingButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        onboardingButton
            .rx
            .tap
            .bind { [weak self] in
                let onboardingViewController = OnboardingOneViewController(reactor: .init())
                onboardingViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(onboardingViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        settingButton
            .rx
            .tap
            .bind { [weak self] in
                let settingViewController = SettingViewController()
                
                settingViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(settingViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        mapButton
            .rx
            .tap
            .bind { [weak self] in
                let mapViewController = MapViewController()
                
                mapViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(mapViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
