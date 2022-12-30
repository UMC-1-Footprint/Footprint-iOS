//
//  WalkRecordCollectionViewCell.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit

class WalkRecordCollectionViewCell: BaseCollectionViewCell {
    let dateLabel: UILabel = .init()
    let footprintImage: UIImageView = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        footprintImage.image = UIImage(named: FootprintIOSAsset.Images.iconFootprint.name)
        
        dateLabel.do {
            $0.text = "2"
            $0.font = .systemFont(ofSize: 10)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([dateLabel, footprintImage])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(6)
        }
        
        footprintImage.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(19)
        }
    }
}
