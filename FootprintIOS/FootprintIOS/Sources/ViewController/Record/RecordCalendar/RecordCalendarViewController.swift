//
//  RecordCalendarViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class RecordCalendarViewController: NavigationBarViewController, View {
    typealias Reactor = RecordCalendarReactor
    
    var pushRecordSearchScreen: () -> RecordSearchViewController
    
    init(reactor: Reactor,
         pushRecordSearchScreen: @escaping () -> RecordSearchViewController) {
        self.pushRecordSearchScreen = pushRecordSearchScreen
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: Reactor) {
        
    }
}

extension RecordCalendarViewController {
    func goToRecordSearchScreen() {
        let controller = pushRecordSearchScreen()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
