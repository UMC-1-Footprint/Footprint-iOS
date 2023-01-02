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
        case prevMonth
        case nextMonth
        case update
    }
    
    enum Mutation {
        case setWalkRecordSection([WalkRecordSectionModel])
        case setCalendarDate(Date)
        case setCalendarMonthTitle(String)
        case setUpdateStatus(Bool)
    }
    
    struct State {
        var walkRecordSection: [WalkRecordSectionModel] = []
        let calendar = Calendar.current
        lazy var components = calendar.dateComponents([.year, .month], from: Date())
        lazy var calendarDate = calendar.date(from: components) ?? Date()
        var monthTitle: String = .init()
        var isUpdated: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh, .update:
            return Observable.concat([
                .just(.setWalkRecordSection(createSection(days: getDays()))),
                .just(.setCalendarMonthTitle(updateMonthTitle()))
            ])
        case .prevMonth:
            return Observable.concat(
                [.just(.setCalendarDate(setPrevMonth())),
                 .just(.setUpdateStatus(true)),
                 .just(.setUpdateStatus(false))
                ])
        case .nextMonth:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setWalkRecordSection(section):
            newState.walkRecordSection = section
        case let .setCalendarDate(date):
            newState.calendarDate = date
        case let .setCalendarMonthTitle(month):
            newState.monthTitle = month
        case let .setUpdateStatus(status):
            newState.isUpdated = status
        }
        return newState
    }
}

extension WalkRecordReactor {
    func createSection(days: [String]) -> [WalkRecordSectionModel] {
        let items = days.map { day -> WalkRecordItem in
            return .calendar(day)
        }
        
        let section = WalkRecordSectionModel.init(model: .calendar(items), items: items)
        
        return [section]
    }
    
    func getDays() -> [String] {
        var state = currentState
        lazy var startDay = state.calendar.component(.weekday, from: state.calendarDate) - 1
        let totalDays = startDay + state.calendar.range(of: .day, in: .month, for: state.calendarDate)!.count
        var days: [String] = []
        
//        let prevMonthEndDay: Date? = Date()
//
//        if startDay > 0 {
//            // 이전 달 날짜를 보여줘야 하는 경우
//            prevMonthEndDay = calendar.date(byAdding: .month, value: -1, to: calendarDate)
//            print("지난달")
//            print(prevMonthEndDay)
//        }
        
        for day in 0..<totalDays {
            if day < startDay {
                print(day, startDay)
                days.append(String())
                continue
            }
            days.append("\(day - startDay + 1)")
        }
        
        return days
    }
    
    func updateMonthTitle() -> String {
        var state = currentState
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월"
        let dateToString = dateFormatter.string(from: state.calendarDate)
        return dateToString
    }
    
    func setPrevMonth() -> Date {
        var state = currentState
        let calendarDate = state.calendar.date(byAdding: DateComponents(month: -1), to: state.calendarDate) ?? Date()
        return calendarDate
    }
}
