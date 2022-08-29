//
//  CalendarViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/23.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit

class CalendarViewController: NavigationBarViewController {
    
    private lazy var infoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("정보 입력 뷰컨 이동", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return btn
    }()
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("캘린더")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(infoButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        infoButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        infoButton.rx.tap
            .bind { [weak self] in
                let infoVC = InfoViewController(reactor: .init())
                infoVC.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(infoVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
