//
//  HashTagStackView.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class HashTagStackView: UIStackView {
    // MARK: - Properties
    
    private var texts: [String] = [] {
        didSet {
            setupProperty()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = 4
        self.distribution = .equalSpacing
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(texts: [String]) {
        self.texts = texts
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() {
        self.subviews.forEach { $0.removeFromSuperview() }
        
        for text in texts {
            let hashTagView: HashTagView = .init(text: text)
            self.addArrangedSubview(hashTagView)
        }
    }
}

class HashTagView: BaseView {
    // MARK: - Properties

    let text: String
    
    // MARK: - UI Components
    
    let label: UILabel = .init()
    
    init(text: String) {
        self.text = text
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        label.font = .systemFont(ofSize: 12)
        label.textColor = FootprintIOSAsset.Colors.blackM.color
        label.text = text
        
        self.makeBorder(color: FootprintIOSAsset.Colors.white3.color, width: 1)
        self.cornerRound(radius: 12)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        self.addSubviews([label])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(text.getSize(font: .systemFont(ofSize: 12)).width + 16)
            $0.height.equalTo(text.getSize(font: .systemFont(ofSize: 12)).height + 12)
        }
    }
}
