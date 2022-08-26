//
//  MyPageViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/23.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class BadgeViewController: NavigationBarViewController {
    let badgeView = BadgeView()
    let testView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("달성 뱃지")
        setNavigationBarBackgroundColor(FootprintIOSAsset.Colors.blueM.color)
        setNavigationBarBackButtonImage(.backButtonIcon)
        setNavigationBarTitleFont(.boldSystemFont(ofSize: 16))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([badgeView,testView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        badgeView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(289)
        }
        
        testView.snp.makeConstraints {
            $0.top.equalTo(badgeView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
