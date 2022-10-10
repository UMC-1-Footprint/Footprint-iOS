//
//  TagView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/10/10.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum TagViewType {
    case gray
    case translucent
}

class TagView: BaseView {
    
    // MARK: - Properties
    
    let type: TagViewType
    
    // MARK: - UI Components
    
    let label: UILabel = .init()
    
    // MARK: - Initializer
    
    init(type: TagViewType, title: String) {
        self.type = type
        
        super.init(frame: .zero)
        
        label.text = title
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        label.textColor = FootprintIOSAsset.Colors.blackL.color
        label.font = .systemFont(ofSize: 10)
        
        self.cornerRound(radius: 5)
        self.backgroundColor = FootprintIOSAsset.Colors.whiteM.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([label])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(1)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
