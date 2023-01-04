//
//  WalkRecordReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class CalendarInfo {
    static let shared = CalendarInfo()
    
    let calendar = Calendar.current
    lazy var components = calendar.dateComponents([.year, .month], from: Date())
    lazy var calendarDate = calendar.date(from: components) ?? Date()
}

class WalkRecordReactor: Reactor {
    enum Action {
        case refresh
        case prevMonth
        case nextMonth
    }
    
    enum Mutation {
        case setWalkRecordSection([WalkRecordSectionModel])
        case setCalendarMonthTitle(String)
        case setUpdateStatus(Bool)
    }
    
    struct State {
        var walkRecordSection: [WalkRecordSectionModel] = []
        var monthTitle: String = .init()
        var isUpdated: Bool = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return Observable.concat([
                .just(.setWalkRecordSection(createCalendarSection(days: getDays()))),
                .just(.setCalendarMonthTitle(updateMonthTitle()))
            ])
        case .prevMonth:
            return Observable.concat(
                [
                 .just(.setWalkRecordSection(createCalendarSection(days: getDays()))),
                 .just(.setCalendarMonthTitle(updateMonthTitle()))
                ])
        case .nextMonth:
            return Observable.concat(
                [
                 .just(.setWalkRecordSection(createCalendarSection(days: getDays()))),
                 .just(.setCalendarMonthTitle(updateMonthTitle()))
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setWalkRecordSection(section):
            newState.walkRecordSection = section
        case let .setCalendarMonthTitle(month):
            newState.monthTitle = month
        case let .setUpdateStatus(status):
            newState.isUpdated = status
        }
        return newState
    }
}

extension WalkRecordReactor {
    func createCalendarSection(days: [String]) -> [WalkRecordSectionModel] {
        let calendarItems = days.map { day -> WalkRecordItem in
            return .calendar(day)
        }
        var recordItems:[WalkRecordItem] = []
        recordItems.append(.walkSummary(.init()))
        recordItems.append(.walkSummary(.init()))
        recordItems.append(.walkSummary(.init()))
        
        let calendarSection = WalkRecordSectionModel.init(model: .calendar(calendarItems), items: calendarItems)
        let recordSection = WalkRecordSectionModel.init(model: .walkSummary(recordItems), items: recordItems)
        
        return [calendarSection, recordSection]
    }
    
    func getDays() -> [String] {
        let calendarInfo = CalendarInfo.shared
        let startDay = calendarInfo.calendar.component(.weekday, from: calendarInfo.calendarDate) - 1
        let totalDays = startDay + calendarInfo.calendar.range(of: .day, in: .month, for: calendarInfo.calendarDate)!.count
        var days: [String] = []
        
        for day in 0..<totalDays {
            if day < startDay {
                days.append(String())
                continue
            }
            days.append("\(day - startDay + 1)")
        }
        
        return days
    }
    
    func updateMonthTitle() -> String {
        let calendarInfo = CalendarInfo.shared
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월"
        let dateToString = dateFormatter.string(from: calendarInfo.calendarDate)
        return dateToString
    }
    
    func setPrevMonth(){
        let calendarInfo = CalendarInfo.shared
        let calendarDate = calendarInfo.calendar.date(byAdding: DateComponents(month: -1), to: calendarInfo.calendarDate) ?? Date()
        calendarInfo.calendarDate = calendarDate
    }
    
    func setNextMonth() {
        let calendarInfo = CalendarInfo.shared
        let calendarDate = calendarInfo.calendar.date(byAdding: DateComponents(month: +1), to: calendarInfo.calendarDate) ?? Date()
        calendarInfo.calendarDate = calendarDate
    }
}
