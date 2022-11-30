//
//  WalkBottomSheetViewController.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit
import SnapKit

final class WalkBottomSheetViewController: BottomSheetViewController,View {
    
    typealias Reactor = WalkBottomSheetReactor
    
    // MARK: - Properties
    
    private let texts = ["이른 오전 (5-8)", "늦은 오전 (9-12)", "이른 오후 (13-16)", "늦은 오후 (17-20)", "밤 (21-0)", "새벽 (1-4)", "매번 다름"]
    
    // MARK: - UI Components
    
    private let contentView = UIView.init()
    
    private let titleLabel = UILabel().then {
        $0.text = "산책 시간대"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private var stackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 30
        $0.axis = .vertical
    }
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(type: .drag)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        for idx in 0..<7 {
            let walkLabel = UILabel().then {
                $0.text = texts[idx]
                $0.font = .systemFont(ofSize: 14)
            }
            stackView.addArrangedSubview(walkLabel)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([titleLabel, stackView])
        
        addContentView(view: contentView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(410)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
        }
    }
    
    // MARK: - Methods
    
    func bind(reactor: WalkBottomSheetReactor) {
        
    }
}
