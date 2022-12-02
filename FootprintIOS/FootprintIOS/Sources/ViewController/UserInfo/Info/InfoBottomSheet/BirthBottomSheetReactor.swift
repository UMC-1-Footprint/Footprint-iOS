//
//  BirthBottomSheetReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class BirthBottomSheetReactor: Reactor {
    
    enum Action {
        case tapDoneButton(String)
    }
    
    enum Mutation {
        case updateBirthInfo(String)
        case dismiss
    }
    
    struct State {
        var birth: String?
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
        case .tapDoneButton(let birth):
            return .concat([
                service.updateBirth(to: birth).map { _ in .dismiss } ,
                .just(.dismiss)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateBirthInfo(let birth):
            newState.birth = birth
        case .dismiss:
            newState.dismiss = true
        }
        
        return newState
    }
}
