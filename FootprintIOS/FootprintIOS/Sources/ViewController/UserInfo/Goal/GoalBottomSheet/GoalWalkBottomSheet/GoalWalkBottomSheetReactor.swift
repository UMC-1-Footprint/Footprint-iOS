//
//  GoalWalkBottomSheetReactor.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/30.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalWalkBottomSheetReactor: Reactor {
    enum Action {
        case tapGoalWalkTime(String)
    }
    
    enum Mutation {
        case updateGoalWalkInfo(String)
        case dismiss
    }
    
    struct State {
        var goalWalk: String?
        var goalWalkNum: Int?
        var dismiss: Bool = true
    }
    
    var initialState: State
    var service: InfoServiceProtocol
    
    init(service: InfoServiceProtocol) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapGoalWalkTime(let goalWalk):
            return service.updateGoalWalk(to: goalWalk).map { _ in .dismiss }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateGoalWalkInfo(let goalWalk):
            newState.goalWalk = goalWalk
        case .dismiss:
            newState.dismiss = true
        }
        
        return newState
    }
}
