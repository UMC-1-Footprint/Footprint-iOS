//
//  HomeReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class HomeReactor: Reactor {
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
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        return newState
    }
}
