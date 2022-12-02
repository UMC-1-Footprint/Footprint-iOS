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
        case updateBirth(String)
    }

    struct State {
        var userInfo: InfoModel?
        var birth: String = ""
    }

    var initialState: State
    var service: InfoServiceProtocol

    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapDoneButton(let info):
            return .just(.setUserInfo(info))
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .updateBirth(let birth):
                return .just(.updateBirth(birth))
            }
        }
        
        return Observable.merge(mutation, event)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUserInfo(let info):
            newState.userInfo = info
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
