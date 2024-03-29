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
        
    }
    
    enum Mutation {
        case updateBirth(String)
    }
    
    struct State {
        var birth: String?
    }
    
    var initialState: State
    var service: InfoServiceType
    
    init(service: InfoServiceType) {
        self.initialState = State()
        self.service = service
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .updateBirth(content: let birth):
                return .just(.updateBirth(birth))
            default:
                return .never()
            }
        }
        
        return Observable.merge(mutation, event)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateBirth(let birth):
            newState.birth = birth
        }
        
        return newState
    }
}

extension InfoReactor {
    func reactorForBirth() -> BirthBottomSheetReactor {
        return BirthBottomSheetReactor(service: service)
    }
}
