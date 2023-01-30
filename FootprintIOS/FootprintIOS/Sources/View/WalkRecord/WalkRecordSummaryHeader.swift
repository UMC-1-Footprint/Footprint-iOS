//
//  WalkRecordSummaryHeader.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/02.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import Then

class WalkRecordSummaryHeader: BaseCollectionReusableView {
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    let summaryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    let topLineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteM.color
    }
    let bottomLineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([topLineView, dateLabel, summaryLabel, bottomLineView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        summaryLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        topLineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalToSuperview()
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}


