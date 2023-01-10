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
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .just(.setGoalInfo(
                GoalInfoDTO(dayIdx: [2, 3],
                            walkGoalTime: 1,
                            walkTimeSlot: 1).toDomain()))
        }
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
