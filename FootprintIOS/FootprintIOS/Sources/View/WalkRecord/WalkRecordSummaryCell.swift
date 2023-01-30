//
//  WalkRecordSummaryCell.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

class WalkRecordSummaryCell: BaseCollectionViewCell {
    // MARK: - UI Components
    
    let imageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    let timeImageView: UIImageView = .init()
    let timeLabel: UILabel = .init()
    let deleteButton: UIButton = .init()
    let hashTagStackView: HashTagStackView = .init()
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .white
        cornerRound(radius: 12)
        setShadow(radius: 16, offset: .init(width: 0, height: 2), opacity: 0.05)
        
        imageView.backgroundColor = .green
        
        timeImageView.image = FootprintIOSAsset.Images.iconTime.image
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.text = "산책 기록 테스트" // 수정바람
        
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = FootprintIOSAsset.Colors.blackL.color
        timeLabel.text = "13:40 ~ 14:01" // 수정바람
        
        deleteButton.setImage(FootprintIOSAsset.Images.iconTrash.image, for: .normal)
        
        hashTagStackView.update(texts: ["테스트1", "테스트2"])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([imageView, titleLabel, timeImageView, timeLabel, deleteButton, hashTagStackView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        
        timeImageView.snp.makeConstraints {
            $0.width.height.equalTo(9)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(timeImageView)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(15)
            $0.width.height.equalTo(12)
        }
        
        hashTagStackView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}
