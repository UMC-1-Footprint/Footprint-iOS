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
        case updateBirth(String)
    }

    struct State {
        var birth: String?
    }

    var initialState: State
    var service: InfoServiceProtocol

    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapDoneButton(let userInfo):
            return updateUserInfoMutation(userInfo)
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .updateInfo(type: let type, content: let birth):
                if type == .birth {
                    return .just(.updateBirth(birth))
                } else {
                    return .never()
                }
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
    func updateUserInfoMutation(_ userInfo: InfoModel) -> Observable<Mutation> {
        service.updateUserInfo(userInfo: userInfo)
        
        return .empty()
    }
    
    func reactorForBirth() -> BirthBottomSheetReactor {
        return BirthBottomSheetReactor(service: service)
    }
    
    func reactorForGoal() -> GoalReactor {
        return GoalReactor(service: service)
    }
}
