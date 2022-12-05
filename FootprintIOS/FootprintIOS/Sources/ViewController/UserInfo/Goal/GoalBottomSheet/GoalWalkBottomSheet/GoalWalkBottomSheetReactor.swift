//
//  GoalWalkBottomSheetReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalWalkBottomSheetReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State
    var service: InfoServiceProtocol
    
    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }
}
