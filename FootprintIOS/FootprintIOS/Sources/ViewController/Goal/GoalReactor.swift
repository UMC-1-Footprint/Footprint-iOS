//
//  GoalReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/08/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalReactor: Reactor {
    enum Action {
        case tapBottomButton
    }

    enum Mutation {
        case updateIsComplete(Bool)
    }

    struct State {
        var isComplete: Bool = false
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapBottomButton:
            return .just(.updateIsComplete(true))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .updateIsComplete(let bool):
            newState.isComplete = bool
        }

        return newState
    }
}
