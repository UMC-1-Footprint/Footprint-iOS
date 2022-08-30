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
    
    let pageButton = UIButton().then{
        $0.setTitle("뱃지 뷰컨으로 이동", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubviews([pageButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        pageButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setupBind() {
        super.setupBind()
        
        pageButton.rx
            .tap
            .bind { [weak self] _ in
                let badgeViewController = BadgeViewController()
                
                self?.navigationController?.pushViewController(badgeViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
