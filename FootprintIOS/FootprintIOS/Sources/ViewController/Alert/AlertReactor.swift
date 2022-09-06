//
//  AlertReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class AlertReactor: Reactor {
    enum Action {
        
    }

    enum Mutation {
        
    }

    struct State {
        
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
            
        }

        return newState
    }
}
