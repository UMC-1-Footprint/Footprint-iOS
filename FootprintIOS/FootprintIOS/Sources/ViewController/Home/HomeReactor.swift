//
//  HomeReactor.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class HomeReactor: Reactor {
    enum HomeViewType {
        case today
        case month
    }
    
    enum Action {
        case refresh
        case scrollHomeContent(x: Int)
        case didEndScroll
        case tapHomeViewTypeButton(HomeViewType)
        case tapTodayDataButton(TodayDataType)
    }
    
    enum Mutation {
        case showIndicatorBar(Int)
        case showHomeContent(Int, HomeViewType)
        case showHomeView(HomeViewType)
        case showTodayData(TodayDataType)
        
        case setMonthSections([MonthSectionModel])
    }
    
    struct State {
        var indicatorX: Int = 0
        var didEndScroll: Int = 0
        var homeViewType: HomeViewType = .today
        var todayDataType: TodayDataType = .percent
        
        var monthSections: [MonthSectionModel] = []
        var monthRow: CGFloat = 0
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .just(.setMonthSections(makeSections()))
        case let .scrollHomeContent(x):
            return .just(.showIndicatorBar(x))
        case .didEndScroll:
            return showHomeContentMutation()
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
        case .showHomeContent(let x, let type):
            newState.didEndScroll = x
            newState.homeViewType = type
        case .showHomeView(let type):
            newState.homeViewType = type
        case .showTodayData(let type):
            newState.todayDataType = type
        case let.setMonthSections(sections):
            newState.monthSections = sections
            newState.monthRow = getRow()
        }
        
        return newState
    }
}

extension HomeReactor {
    func showHomeContentMutation() -> Observable<Mutation> {
        let width = UIScreen.main.bounds.width
        let x = currentState.indicatorX
        let type: HomeViewType = (x < Int(width) / 2) ? .today : .month
        
        return .just(.showHomeContent(x, type))
    }
    
    func makeSections() -> [MonthSectionModel] {
        let days = getDays()
        
        let items = days.map { (day) -> MonthItem in
            return .month(MonthCollectionViewCellReactor(state: .init(day: day)))
        }
        
        let section = MonthSectionModel.init(model: .month(items), items: items)

        return [section]
    }
}

extension HomeReactor {
    func getDays() -> [String] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let calendarDate = calendar.date(from: components)

        let daysCount = calendar.range(of: .day, in: .month, for: calendarDate!)?.count ?? 0
        let firstDay = calendar.component(.weekday, from: calendarDate!)
        
        var days = [String](repeating: "", count: firstDay)
        
        for day in 1...daysCount {
            days.append("\(day)")
        }
        
        return days
    }
    
    
    func getRow() -> CGFloat {
        let row = getDays().count > 35 ? 6 : 5
        
        return CGFloat(row)
    }
}
