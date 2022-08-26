//
//  BadgeView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class BadgeView: BaseView {
    
    let backgroundView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueL.color.withAlphaComponent(0.3)
    }
    
    let backgroundImage = UIImageView().then {
        $0.image = .badgeBackgroundImage
        $0.contentMode = .scaleAspectFill
    }
    
    let representBadgeStackView = UIStackView().then {
        $0.backgroundColor = UIColor(patternImage: .representBadgeBackground!)
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }

    let representBadgeImage = UIImageView().then {
        $0.image = .representBadge
    }

    let representBadgeTitle = UILabel().then {
        $0.text = "대표 뱃지"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .white
    }
    
    let badgeImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.startBadge.image
    }
    
    let badgeName = UILabel().then {
        $0.text = "발자국 스타터"
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        representBadgeStackView.addArrangedSubview(representBadgeImage)
        representBadgeStackView.addArrangedSubview(representBadgeTitle)
        backgroundView.addSubviews([backgroundImage, representBadgeStackView])
        addSubviews([backgroundView, badgeImage, badgeName])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        representBadgeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(92)
            $0.height.equalTo(26)
        }

        representBadgeStackView.isLayoutMarginsRelativeArrangement = true
        representBadgeStackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 7.0, bottom: 0.0, right: 0.0)

        representBadgeImage.snp.makeConstraints {
            $0.width.equalTo(19)
            $0.height.equalTo(19)
        }
        
        badgeImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(representBadgeStackView.snp.bottom).offset(23)
            $0.width.height.equalTo(150)
        }
        
        badgeName.snp.makeConstraints {
            $0.top.equalTo(badgeImage.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
    }
    
}
