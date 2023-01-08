//
//  RecordCollectionViewCell.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class RecordCollectionViewCell: BaseCollectionViewCell, View {
    // MARK: - Properties
    
    typealias Reactor = RecordCollectionViewCellReactor
    
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
        
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = FootprintIOSAsset.Colors.blackL.color
        
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
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
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
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {
        titleLabel.text = "산책기록 테스트"
        timeLabel.text = "13:40 ~ 14:01"
    }
}
