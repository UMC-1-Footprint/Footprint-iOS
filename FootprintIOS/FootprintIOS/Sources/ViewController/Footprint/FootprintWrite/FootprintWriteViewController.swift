//
//  FootprintWriteViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class FootprintWriteViewController: NavigationBarViewController, View {
    // MARK: - Constants
    
    typealias Reactor = FootprintWriteReactor
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        
        // TODO: - 테스트용
        view.backgroundColor = .cyan
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind Method
    
    func bind(reactor: Reactor) {

    }
}
