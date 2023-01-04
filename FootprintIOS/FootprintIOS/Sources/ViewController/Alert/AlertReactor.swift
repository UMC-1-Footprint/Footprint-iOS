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
        case tapCancelButton
    }

    enum Mutation {
        case updateIsDismiss
    }

    struct State {
        var isDismiss: Bool = false
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapCancelButton:
            return .just(.updateIsDismiss)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .updateIsDismiss:
            newState.isDismiss = true
        }

        return newState
    }
}
