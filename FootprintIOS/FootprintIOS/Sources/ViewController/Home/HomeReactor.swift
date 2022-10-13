//
//  HomeReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class HomeReactor: Reactor {
    enum Action {
        case scrollHomeContent(x: Int)
        case didEndScroll
        case tapTodayButton
        case tapMonthButton
    }
    
    enum Mutation {
        case showIndicatorBar(Int)
        case showHomeContent
        case showTodayView
        case showMonthView
    }
    
    struct State {
        var indicatorX: Int = 0
        var didEndScroll: Bool = false
        var isTodayView: Bool = true
        var isMonthView: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .scrollHomeContent(x):
            return .just(.showIndicatorBar(x))
        case .didEndScroll:
            return .just(.showHomeContent)
        case .tapTodayButton:
            return .just(.showTodayView)
        case .tapMonthButton:
            return .just(.showMonthView)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .showIndicatorBar(let x):
            newState.indicatorX = x
        case .showHomeContent:
            newState.didEndScroll = true
        case .showTodayView:
            newState.isTodayView = true
            newState.isMonthView = false
        case .showMonthView:
            newState.isTodayView = false
            newState.isMonthView = true
        }
        
        return newState
    }
}
