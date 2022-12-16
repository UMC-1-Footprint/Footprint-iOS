//
//  ImageCollectionViewCell.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class ImageCollectionViewCell: BaseCollectionViewCell, View {
    typealias Reactor = ImageCollectionViewCellReactor
    
    // MARK: - UI Components
    
    let imageView: UIImageView = .init()
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        imageView.cornerRound(radius: 8)
        imageView.backgroundColor = .red
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([imageView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        imageView.image = reactor.currentState.image
    }
}
