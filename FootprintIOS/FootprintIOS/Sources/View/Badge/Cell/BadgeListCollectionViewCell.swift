//
//  BadgeListViewCell.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/29.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class BadgeListCollectionViewCell: BaseCollectionViewCell {
   static let identifier = "BadgeListViewCell"

    var badgeImage = UIImageView()
    var badgeTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([badgeImage, badgeTitle])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        badgeImage.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalToSuperview()
        }
        
        badgeTitle.snp.makeConstraints {
            $0.top.equalTo(badgeImage.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    func setBadgeListCell(badge: BadgeModel) {
        badgeImage.image = badge.badgeImage
        badgeTitle.text = badge.badgeTitle
    }
}
