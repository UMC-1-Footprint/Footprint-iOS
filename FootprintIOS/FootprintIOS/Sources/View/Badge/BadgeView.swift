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
    
    // MARK: - UI Components
    let backgroundView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.blueL.color.withAlphaComponent(0.3)
    }
    
    let backgroundImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.badgeBackground.image
        $0.contentMode = .scaleAspectFill
    }
    
    let representBadgeStackView = UIStackView().then {
        $0.backgroundColor = UIColor(patternImage: FootprintIOSAsset.Images.representBadgeBackground.image)
        $0.axis = .horizontal
        $0.spacing = 3
        $0.alignment = .center
    }

    let representBadgeImage = UIImageView().then {
        $0.image = FootprintIOSAsset.Images.representBadge.image
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
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 4
        $0.minimumInteritemSpacing = 14
        $0.sectionInset = UIEdgeInsets(top: 15, left: 23, bottom: 15, right: 23)
    }

    lazy var badgeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.backgroundColor = FootprintIOSAsset.Colors.white2.color
        $0.register(BadgeListCollectionViewCell.self, forCellWithReuseIdentifier: BadgeListCollectionViewCell.identifier)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        representBadgeStackView.addArrangedSubview(representBadgeImage)
        representBadgeStackView.addArrangedSubview(representBadgeTitle)
        backgroundView.addSubviews([backgroundImage, representBadgeStackView])
        addSubviews([backgroundView, badgeImage, badgeName, badgeListCollectionView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(289)
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
            $0.width.height.equalTo(19)
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
        
        badgeListCollectionView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


