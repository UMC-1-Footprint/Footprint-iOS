//
//  OnboardingReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class OnboardingReactor: Reactor {
    enum Action {
        case tapBottomButton
    }
    
    enum Mutation {
        case updateIsPresent(Bool)
    }
    
    struct State {
        var isPresent: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapBottomButton:
            return .concat([
                .just(.updateIsPresent(true)),
                .just(.updateIsPresent(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateIsPresent(let bool):
            newState.isPresent = bool
        }
        
        return newState
    }
}
