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
        case updateWalk(String)
        case updateGoalWalk(String)
    }
    
    struct State {
        var isSelectedButtons: [Bool] = [false, false, false, false, false, false, false]
        var walk: String?
        var goalWalk: String?
        var isEnabledDoneButton: [Bool] = [false, false, false]
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
            return updateInfoMutation(info)
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .updateWalk(content: let walk):
                return .just(.updateWalk(walk))
            case .updateGoalWalk(content: let goalWalk):
                return .just(.updateGoalWalk(goalWalk))
            default:
                return .never()
            }
        }
        
        return Observable.merge(mutation, event)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateDayButton(let day):
            newState.isSelectedButtons[day] = !newState.isSelectedButtons[day]
            newState.isEnabledDoneButton[0] = newState.isSelectedButtons.filter { $0 }.count > 0
        case .updateWalk(let walk):
            newState.walk = walk
            newState.isEnabledDoneButton[1] = true
        case .updateGoalWalk(let goalWalk):
            newState.goalWalk = goalWalk
            newState.isEnabledDoneButton[2] = true
        }
        
        return newState
    }
}

extension GoalReactor {
    func updateInfoMutation(_ goalInfo: GoalModel) -> Observable<Mutation> {
        service.updateGoalInfo(goalInfo: goalInfo)
        service.createInfo()
        
        return .empty()
    }
    
    func reactorForWalk() -> WalkBottomSheetReactor {
        return WalkBottomSheetReactor(service: service)
    }
    
    func reactorForGoalWalk() -> GoalWalkBottomSheetReactor {
        return GoalWalkBottomSheetReactor(service: service)
    }
}
