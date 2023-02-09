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
        case selectGoalWalkTime
        case dismiss
    }
    
    struct State {
        var goalWalk: String?
        var goalWalkNum: Int?
        var showGoalWalkTimeAlertView: Bool = false
        var dismiss: Bool = true
    }
    
    var initialState: State
    var service: InfoServiceType
    
    init(service: InfoServiceType) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapGoalWalkTime(let goalWalkTime):
            return goalWalkTimeMutation(goalWalkTime)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateGoalWalkInfo(let goalWalk):
            newState.goalWalk = goalWalk
        case .selectGoalWalkTime:
            newState.showGoalWalkTimeAlertView = true
        case .dismiss:
            newState.dismiss = true
            newState.showGoalWalkTimeAlertView = false
        }
        
        return newState
    }
}

extension GoalWalkBottomSheetReactor {
    private func goalWalkTimeMutation(_ goalWalkTime: String) -> Observable<Mutation> {
        if goalWalkTime == "직접 설정" {
            return .just(.selectGoalWalkTime)
        } else {
            return service.updateGoalWalk(to: goalWalkTime).map { _ in .dismiss }
        }
    }
}
