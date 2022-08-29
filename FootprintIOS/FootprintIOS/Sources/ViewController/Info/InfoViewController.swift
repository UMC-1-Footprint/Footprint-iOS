//
//  InfoViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class InfoViewController: NavigationBarViewController, View {
    
    // MARK: - Properties
    
    typealias Reactor = InfoReactor
    
    // MARK: - UI Components
    
    private let infoView: InfoView = .init()
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(infoView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        infoView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: InfoReactor) {
        // Action
        // State
    }
}
