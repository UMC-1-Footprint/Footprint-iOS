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
    let calendar = Calendar.current
    lazy var components = calendar.dateComponents([.year, .month], from: Date())
    lazy var calendarDate = calendar.date(from: components) ?? Date()
    
    let walkRecordService: WalkRecordServiceType
    
    init(walkRecordService: WalkRecordServiceType) {
        self.initialState = State()
        self.walkRecordService = walkRecordService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refreshMutation()
        case .prevMonth:
            setPrevMonth()
            return Observable.concat(
                [
                 .just(.setWalkRecordSection(createCalendarSection(days: getDays()))),
                 .just(.setCalendarMonthTitle(updateMonthTitle()))
                ])
        case .nextMonth:
            setNextMonth()
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
    func refreshMutation() -> Observable<Mutation> {
        walkRecordService.getNumber(year: 2023, month: 1)
        
        walkRecordService.event
            .subscribe(onNext: { event in
                switch event {
                case let .getNumber(data):
                    print("number data")
                    print(data)
                }
            })
        
        return Observable.concat([
            .just(.setWalkRecordSection(createCalendarSection(days: getDays()))),
            .just(.setCalendarMonthTitle(updateMonthTitle()))
        ])
    }
    
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
        let startDay = calendar.component(.weekday, from: calendarDate) - 1
        let totalDays = startDay + calendar.range(of: .day, in: .month, for: calendarDate)!.count
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
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월"
        let dateToString = dateFormatter.string(from: calendarDate)
        return dateToString
    }
    
    func setPrevMonth(){
        let calendarDate = calendar.date(byAdding: DateComponents(month: -1), to: calendarDate) ?? Date()
        self.calendarDate = calendarDate
    }
    
    func setNextMonth() {
        let calendarDate = calendar.date(byAdding: DateComponents(month: +1), to: calendarDate) ?? Date()
        self.calendarDate = calendarDate
    }
}
