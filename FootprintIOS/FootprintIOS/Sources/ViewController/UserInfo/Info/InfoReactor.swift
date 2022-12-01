//
//  InfoReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/08/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class InfoReactor: Reactor {
    enum Action {
        case tapDoneButton(InfoModel)
    }

    enum Mutation {
        case setUserInfo(InfoModel)
    }

    struct State {
        var userInfo: InfoModel?
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapDoneButton(let info):
            return .just(.setUserInfo(info))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUserInfo(let info):
            newState.userInfo = info
        }

        return newState
    }
}
