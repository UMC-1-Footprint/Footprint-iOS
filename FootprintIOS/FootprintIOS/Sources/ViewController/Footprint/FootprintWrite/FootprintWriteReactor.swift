//
//  FootprintWriteReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class FootprintWriteReactor: Reactor {
    enum Action {
        case editText(String)
    }
    
    enum Mutation {
        case updateText(String)
    }
    
    struct State {
        var text: String = ""
    }
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}

extension FootprintWriteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .editText(text):
            return .just(.updateText(text))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .updateText(text):
            newState.text = text
        }
        
        return newState
    }
}
