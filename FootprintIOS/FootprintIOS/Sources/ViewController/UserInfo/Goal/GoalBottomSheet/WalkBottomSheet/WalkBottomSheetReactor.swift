//
//  WalkBottomSheetReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class WalkBottomSheetReactor: Reactor {
    
    enum Action {
        case tapWalkButton(String)
    }
    
    enum Mutation {
        case updateWalkInfo(String)
        case dismiss
    }
    
    struct State {
        var walk: String?
        var walkNum: Int?
        var dismiss: Bool = false
    }
    
    var initialState: State
    var service: InfoServiceProtocol
    
    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapWalkButton(let walk):
            return .concat([
                service.updateWalk(to: walk).map { _ in .dismiss },
                .just(.updateWalkInfo(walk))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateWalkInfo(let walk):
            newState.walk = walk
        case .dismiss:
            newState.dismiss = true
        }
        
        return newState
    }
}

