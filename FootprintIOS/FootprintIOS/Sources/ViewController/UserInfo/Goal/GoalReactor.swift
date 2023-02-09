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
        case tapDoneButton(GoalRequestDTO)
    }
    
    enum Mutation {
        case updateDayButton(Int)
        case updateWalk(String)
        case updateGoalWalk(String)
        case showGoalWalkAlertView
    }
    
    struct State {
        var isSelectedButtons: [Bool] = [false, false, false, false, false, false, false]
        var walk: String?
        var goalWalk: String?
        var isEnabledDoneButton: [Bool] = [false, false, false]
        var isPresentGoalWalkSelectView: Bool = false
    }
    
    var initialState: State
    var service: InfoServiceType
    var userInfo: UserInfoRequestModel

    init(service: InfoServiceType, userInfo: UserInfoRequestModel) {
        self.initialState = State()
        self.service = service
        self.userInfo = userInfo
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
            case .showGoalWalkAlertView:
                return .just(.showGoalWalkAlertView)
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
            newState.isPresentGoalWalkSelectView = false
        case .updateWalk(let walk):
            newState.walk = walk
            newState.isEnabledDoneButton[1] = true
            newState.isPresentGoalWalkSelectView = false
        case .updateGoalWalk(let goalWalk):
            newState.goalWalk = goalWalk
            newState.isEnabledDoneButton[2] = true
            newState.isPresentGoalWalkSelectView = false
        case .showGoalWalkAlertView:
            newState.isPresentGoalWalkSelectView = true
            newState.isEnabledDoneButton[2] = true
        }
        
        return newState
    }
}

extension GoalReactor {
    func updateInfoMutation(_ goalInfo: GoalRequestDTO) -> Observable<Mutation> {
        service.postUserInfo(userInfo: userInfo, goalInfo: goalInfo)
        
        return .empty()
    }
    
    func reactorForWalk() -> WalkBottomSheetReactor {
        return WalkBottomSheetReactor(service: service)
    }
    
    func reactorForGoalWalk() -> GoalWalkBottomSheetReactor {
        return GoalWalkBottomSheetReactor(service: service)
    }
}
