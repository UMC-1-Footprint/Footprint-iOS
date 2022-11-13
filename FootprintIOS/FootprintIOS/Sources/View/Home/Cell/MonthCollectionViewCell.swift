//
//  MonthCollectionViewCell.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/04.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class MonthCollectionViewCell: BaseCollectionViewCell, View {
    
    // MARK: - Properties
    
    typealias Reactor = MonthCollectionViewCellReactor
    
    // MARK: - UI Components
    
    let dayRoundView = UIView().then {
        //$0.backgroundColor = FootprintIOSAsset.Colors.blueM.color.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 16
    }
    
    let dayLabel = UILabel().then {
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .center
    }
    
    // MARK: - Methods
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([dayRoundView, dayLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dayRoundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(32)
        }
        
        dayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        dayLabel.text = reactor.currentState.day
    }
}
