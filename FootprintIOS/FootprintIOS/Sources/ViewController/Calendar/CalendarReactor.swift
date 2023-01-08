//
//  CalendarReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/21.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

import ReactorKit

class CalendarReactor: Reactor {
    enum Action {
        case delete
    }
    
    enum Mutation {
        case deleteFootprint
    }
    
    struct State {
        var isDeleted: Bool = false
    }
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        print(action)
        switch action {
        case .delete:
            return .just(.deleteFootprint)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .deleteFootprint:
            newState.isDeleted = true
        }
        
        return newState
    }
}
