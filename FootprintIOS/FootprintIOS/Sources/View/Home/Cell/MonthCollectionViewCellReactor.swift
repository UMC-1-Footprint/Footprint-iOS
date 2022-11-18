//
//  MonthCollectionViewCellReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/04.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class MonthCollectionViewCellReactor: Reactor {
    enum Action { }
    enum Mutation {}
    
    struct State {
        var day: String
    }
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}
