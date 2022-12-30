//
//  WalkRecordReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class WalkRecordReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setWalkRecordSection([WalkRecordSectionModel])
    }
    
    struct State {
        var walkRecordSection: [WalkRecordSectionModel] = []
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
}

extension WalkRecordReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .just(.setWalkRecordSection(createSection()))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setWalkRecordSection(section):
            newState.walkRecordSection = section
        }
        return newState
    }
    
    func createSection() -> [WalkRecordSectionModel] {
        let days = getDays()
        
        let items = days.map { day -> WalkRecordItem in
            return .calendar
        }
        
        let section = WalkRecordSectionModel.init(model: .calendar(items), items: items)
        
        return [section]
    }
    
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
}
