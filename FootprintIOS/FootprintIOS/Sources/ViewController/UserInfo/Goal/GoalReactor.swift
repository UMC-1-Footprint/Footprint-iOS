//
//  GoalReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/08/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalReactor: Reactor {
    enum Action {
        case tapDayButton(Int)
        case tapDoneButton(GoalModel)
    }
    
    enum Mutation {
        case updateDayButton(Int)
        case setInfo(GoalModel)
    }
    
    struct State {
        var day: Int?
        var isSelectedButtons: [Bool] = [false, false, false, false, false, false, false]
        var goalInfo: GoalModel?
    }
    
    var initialState: State
    var service: InfoServiceProtocol

    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapDayButton(let day):
            return .just(.updateDayButton(day))
        case .tapDoneButton(let info):
            return .just(.setInfo(info))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateDayButton(let day):
            newState.day = day
            newState.isSelectedButtons[day] = !newState.isSelectedButtons[day]
        case .setInfo(let info):
            newState.goalInfo = info
        }
        
        return newState
    }
}
