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
        $0.layer.cornerRadius = 16
    }
    
    let dayLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    
    func bind(reactor: Reactor) {
        dayLabel.text = "\(reactor.currentState.day)"
    }
}
