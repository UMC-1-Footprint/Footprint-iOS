//
//  GoalEditNextMonthViewController.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

final class GoalEditNextMonthViewController: NavigationBarViewController, View {
    
    typealias Reactor = GoalEditNextMonthReactor
    
    // MARK: - Initializer
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func bind(reactor: GoalEditNextMonthReactor) {
        
    }
}
