//
//  AgreementReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/09/01.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

enum ButtonType {
    case first
    case second
    case third
    case fourth
}

class AgreementReactor: Reactor {
    enum Action {
        case selectButton(ButtonType)
    }
    
    enum Mutation {
        case updateButton(ButtonType)
    }
    
    struct State {
        var isSelectedFirstButton: Bool = false
        var isSelectedSecondButton: Bool = false
        var isSelectedThirdButton: Bool = false
        var isSelectedFourthButton: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectButton(let buttonType):
            return .just(.updateButton(buttonType))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateButton(let buttonType):
            switch buttonType {
            case .first:
                newState.isSelectedFirstButton = !state.isSelectedFirstButton
            case .second:
                newState.isSelectedSecondButton = !state.isSelectedSecondButton
            case .third:
                newState.isSelectedThirdButton = !state.isSelectedThirdButton
            case .fourth:
                newState.isSelectedFourthButton = !state.isSelectedFourthButton
            }
        }
        
        return newState
    }
}
