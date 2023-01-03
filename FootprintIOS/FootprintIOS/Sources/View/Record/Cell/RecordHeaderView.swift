//
//  RecordHeaderView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

import UIKit

class RecordHeaderView: BaseCollectionReusableView {
    // MARK: - UI Components
    let titleLabel: UILabel = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "9월 23일 수요일"
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([titleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(25)
        }
    }
}

