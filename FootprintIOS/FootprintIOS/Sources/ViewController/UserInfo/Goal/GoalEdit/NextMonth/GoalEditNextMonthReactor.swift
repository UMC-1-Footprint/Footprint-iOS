//
//  GoalEditNextMonthReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2023/01/08.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import ReactorKit

class GoalEditNextMonthReactor: Reactor {
    enum Action {
        case refresh
        case tapDayButton(Int)
        case tapSaveButton(GoalInfoDTO)
    }
    
    enum Mutation {
        case setGoalInfo(GoalModel)
        case setDayButtons([Bool])
        case updateDayButton(Int)
        case updateWalk(String)
        case updateGoalWalk(String)
    }
    
    struct State {
        var goalInfo: GoalModel
        var isSelectedButtons: [Bool] = [false, false, false, false, false, false, false]
        var walk: String?
        var goalWalk: String?
    }
    
    var initialState: State
    var service: InfoServiceProtocol

    init(service: InfoServiceProtocol, goalInfo: GoalModel) {
        self.initialState = State(goalInfo: goalInfo)
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .concat(
                .just(.setGoalInfo(initialState.goalInfo)),
                setDayButtons(days: initialState.goalInfo.dayIdx)
            )
        case .tapDayButton(let day):
            return .just(.updateDayButton(day))
        case .tapSaveButton(let info):
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
        case let .setGoalInfo(goalInfo):
            newState.goalInfo = goalInfo
        case let .setDayButtons(dayButtons):
            newState.isSelectedButtons = dayButtons
        case .updateDayButton(let day):
            newState.isSelectedButtons[day] = !newState.isSelectedButtons[day]
        case .updateWalk(let walk):
            newState.walk = walk
        case .updateGoalWalk(let goalWalk):
            newState.goalWalk = goalWalk
        }
        return newState
    }
}

extension GoalEditNextMonthReactor {
    func setDayButtons(days: [Int]) -> Observable<Mutation> {
        var dayButtons: [Bool] = [false, false, false, false, false, false, false]
        
        for (index, _) in dayButtons.enumerated() {
            if days.contains(index) {
                dayButtons[index] = true
            }
        }
        
        return .just(.setDayButtons(dayButtons))
    }
    
    func updateInfoMutation(_ goalInfo: GoalInfoDTO) -> Observable<Mutation> {
        service.updateGoalInfo(goalInfo: goalInfo)
        service.editGoalInfo()
        
        return .empty()
    }
    
    func reactorForWalk() -> WalkBottomSheetReactor {
        return WalkBottomSheetReactor(service: service)
    }
    
    func reactorForGoalWalk() -> GoalWalkBottomSheetReactor {
        return GoalWalkBottomSheetReactor(service: service)
    }
}
