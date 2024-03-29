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
        case tapSaveButton(GoalRequestDTO)
    }
    
    enum Mutation {
        case setGoalInfo(GoalModel)
        case setDayButtons([Bool])
        case updateDayButton(Int)
        case updateWalk(String)
        case updateGoalWalk(String)
        case saveGoal(Bool?)
    }
    
    struct State {
        var goalInfo: GoalModel?
        var isSelectedButtons: [Bool] = [false, false, false, false, false, false, false]
        var walk: String?
        var goalWalk: String?
        var save: Bool?
    }
    
    var initialState: State
    var service: InfoServiceType
    
    init(service: InfoServiceType) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            service.getNextMonthGoal()
            return .empty()
        case .tapDayButton(let day):
            return .just(.updateDayButton(day))
        case .tapSaveButton(let info):
            service.patchNextMonthGoal(goalInfo: info)
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = service.event.flatMap { [weak self] event -> Observable<Mutation> in
            guard let `self` = self else { return .empty() }
            
            switch event {
            case let .getNextMonthGoal(goalInfo):
                return .concat(
                    .just(.setGoalInfo(goalInfo.toDomain())),
                    self.setDayButtons(days: goalInfo.dayIdx)
                )
            case let .patchNextMonthGoal(isSuccess):
                return .concat(
                    .just(.saveGoal(isSuccess)),
                    .just(.saveGoal(nil))
                )
            case let .updateWalk(content: walk):
                return .just(.updateWalk(walk))
            case let .updateGoalWalk(content: goalWalk):
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
        case let .saveGoal(isSuccess):
            newState.save = isSuccess
        }
        return newState
    }
}

extension GoalEditNextMonthReactor {
    func setDayButtons(days: [Int]) -> Observable<Mutation> {
        var dayButtons: [Bool] = [false, false, false, false, false, false, false, false]
        
        for (index, _) in dayButtons.enumerated() {
            if days.contains(index) {
                dayButtons[index - 1] = true
            }
        }
        
        return .just(.setDayButtons(dayButtons))
    }
    
    func reactorForWalk() -> WalkBottomSheetReactor {
        return WalkBottomSheetReactor(service: service)
    }
    
    func reactorForGoalWalk() -> GoalWalkBottomSheetReactor {
        return GoalWalkBottomSheetReactor(service: service)
    }
}
