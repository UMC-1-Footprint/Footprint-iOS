//
//  GoalEditThisMonthReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalEditThisMonthReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setGoalInfo(GoalModel)
    }
    
    struct State {
        var goalInfo: GoalModel?
    }
    
    var initialState: State
    let service: InfoServiceProtocol
    
    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            service.getThisMonthGoal()
            return .empty()
        }
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case let .getThisMonthGoal(goalInfo):
                return .just(.setGoalInfo(goalInfo.toDomain()))
            default:
                return .never()
            }
        }
        
        return Observable.merge(mutation, event)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setGoalInfo(goalInfo):
            newState.goalInfo = goalInfo
        }
        
        return newState
    }
}
