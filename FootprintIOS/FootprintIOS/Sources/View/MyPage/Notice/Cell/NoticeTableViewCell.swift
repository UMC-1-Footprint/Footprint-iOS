//
//  NoticeTableViewCell.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit
import UIKit

class NoticeTableViewCell: BaseTableViewCell, View {
    typealias Reactor = NoticeTableViewCellReactor
    
    // MARK: - UI Components
    
    let titleLabel: UILabel = .init()
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "[공지] 새로운 기능이 업데이트 됐어요!"
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([titleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        
    }
}
