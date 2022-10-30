//
//  HomeReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class HomeReactor: Reactor {
    enum HomeViewType {
        case today
        case month
    }
    
    enum Action {
        case scrollHomeContent(x: Int)
        case didEndScroll
        case tapHomeViewTypeButton(HomeViewType)
        case tapTodayDataButton(TodayDataType)
    }
    
    enum Mutation {
        case showIndicatorBar(Int)
        case showHomeContent(Int)
        case showHomeView(HomeViewType)
        case showTodayData(TodayDataType)
    }
    
    struct State {
        var indicatorX: Int = 0
        var didEndScroll: Int = 0
        var homeViewType: HomeViewType = .today
        var todayDataType: TodayDataType = .percent
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
            return .just(.showHomeContent(currentState.indicatorX))
        case .tapHomeViewTypeButton(let type):
            return .just(.showHomeView(type))
        case .tapTodayDataButton(let type):
            return .just(.showTodayData(type))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .showIndicatorBar(let x):
            newState.indicatorX = x
        case .showHomeContent(let x):
            newState.didEndScroll = x
        case .showHomeView(let type):
            newState.homeViewType = type
        case .showTodayData(let type):
            newState.todayDataType = type
        }
        
        return newState
    }
}
