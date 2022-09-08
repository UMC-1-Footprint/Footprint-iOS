//
//  AlertReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/09/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class AlertReactor: Reactor {
    enum Action {
        case tapCancelButton
        case tapAlertButton(AlertType)
    }

    enum Mutation {
        case updateIsDismiss
    }

    struct State {
        var isDismiss: Bool = false
    }

    var initialState: State

    init() {
        self.initialState = State()
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapCancelButton:
            return .just(.updateIsDismiss)
        case .tapAlertButton(let alertType):
            switch alertType {
            case .noGoal, .changeGoal, .badge(_):
                break
            case .delete:
                // 서버 통신
                break
            case .save(let i):
                //
                break
            case .cancel(let i):
                //
                break
            case .setBadge:
                //
                break
            case .logout:
                //
                break
            case .withdrawal:
                //
                break
            case .deleteAll(let i):
                //
                break
            case .custom:
                //
                break
            }
            return .just(.updateIsDismiss)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .updateIsDismiss:
            newState.isDismiss = true
        }

        return newState
    }
}
