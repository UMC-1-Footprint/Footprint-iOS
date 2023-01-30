//
//  WalkRecordReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/27.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

struct WalkRecordModel {
    let day: String
    let footprintNumber: Int
}

class WalkRecordReactor: Reactor {
    enum Action {
        case refresh
        case prevMonth
        case nextMonth
        case updateDetail(String)
    }
    
    enum Mutation {
        case setWalkRecordSection([WalkRecordSectionModel])
        case setCalendarMonthTitle(String)
        case setHeaderDateTitle(String)
        case setUpdateStatus(Bool)
        case updateDetailCount(String)
    }
    
    struct State {
        var walkRecordSection: [WalkRecordSectionModel] = []
        var monthTitle: String = .init()
        var isUpdated: Bool = false
        var headerDateTitle: String = .init()
        var detailCount: String = .init()
    }
    
    let initialState: State
    let calendar = Calendar.current
    lazy var components = calendar.dateComponents([.year, .month], from: Date())
    lazy var calendarDate = calendar.date(from: components) ?? Date()
    lazy var startDay = calendar.component(.weekday, from: calendarDate) - 1
    lazy var monthDays = calendar.range(of: .day, in: .month, for: calendarDate)!.count
    lazy var totalDays = startDay + monthDays
    var hasFootprintOfMonth:[Int] = []
    var footprintDetail:[WalkRecordDetailResponseDTO] = []
    
    let service: WalkRecordServiceType
    
    init(service: WalkRecordServiceType) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refreshMutation()
        case .prevMonth:
            return getPrevMonthMutation()
        case .nextMonth:
            return getNextMonthMutation()
        case let .updateDetail(date):
            return updateDeatilMutation(date: date)
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
        case let .setHeaderDateTitle(date):
            newState.headerDateTitle = date
        case let .updateDetailCount(count):
            newState.detailCount = count
        }
        return newState
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = service.event
            .flatMap({ (event) -> Observable<Mutation> in
                switch event {
                case let .getNumber(data):
                    self.hasFootprintOfMonth = self.getWalkRecordOfMonth(date: data)
                    return .just(.setWalkRecordSection(self.createCalendarSection(model: self.getDays())))
                case let .getDetail(data):
                    self.footprintDetail = data
                    return Observable.concat([
                        .just(.setWalkRecordSection(self.createCalendarSection(model: self.getDays()))),
                        .just(.updateDetailCount(String(data.count)))
                    ])
                }
            })
        
        return Observable.merge(mutation, eventMutation)
    }
    
}

extension WalkRecordReactor {
    func refreshMutation() -> Observable<Mutation> {
        service.getNumber(year: calendarDate.year, month: calendarDate.month)
        service.getDetail(date: Date().toString(dateFormat: "yyyy-MM-dd"))

        return Observable.concat([
            .just(.setCalendarMonthTitle(updateMonthTitle(dateFormat: "yyyy년 MM월"))),
            .just(.setHeaderDateTitle(Date().toString(dateFormat: "yyyy년 MM월 dd일")))
        ])
    }
    
    func getPrevMonthMutation() -> Observable<Mutation> {
        setPrevMonth()
        service.getNumber(year: calendarDate.year, month: calendarDate.month)
        
        return Observable.concat([
            .just(.setWalkRecordSection(createCalendarSection(model: getDays()))),
            .just(.setCalendarMonthTitle(updateMonthTitle(dateFormat: "yyyy년 MM월")))
        ])
    }
    
    func getNextMonthMutation() -> Observable<Mutation> {
        setNextMonth()
        service.getNumber(year: calendarDate.year, month: calendarDate.month)
        
        return Observable.concat([
            .just(.setWalkRecordSection(createCalendarSection(model: getDays()))),
            .just(.setCalendarMonthTitle(updateMonthTitle(dateFormat: "yyyy년 MM월")))
        ])
    }
    
    func updateDeatilMutation(date: String) -> Observable<Mutation> {
        service.getDetail(date: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone? 
        guard let date: Date = dateFormatter.date(from: date) else { return .empty() }
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let dateToString = dateFormatter.string(from: date)
        
        return .just(.setHeaderDateTitle(dateToString))
    }
    
    func createCalendarSection(model: [WalkRecordModel]) -> [WalkRecordSectionModel] {
        let calendarItems = model.map { item -> WalkRecordItem in
            return .calendar(item)
        }
        
        let recordItems = self.footprintDetail.map { item -> WalkRecordItem in
            return .walkSummary(item)
        }
        
        let calendarSection = WalkRecordSectionModel.init(model: .calendar(calendarItems), items: calendarItems)
        let recordSection = WalkRecordSectionModel.init(model: .walkSummary(recordItems), items: recordItems)
        
        return [calendarSection, recordSection]
    }
    
    func refreshSection() -> [WalkRecordSectionModel] {
        let calendarSection = WalkRecordSectionModel(model: .calendar(.init()), items: .init())
        let recordSection = WalkRecordSectionModel(model: .walkSummary(.init()), items: .init())
        
        return [calendarSection, recordSection]
    }
    
    func getDays() -> [WalkRecordModel] {
        var days: [WalkRecordModel] = []
        let walkRecordNum:[Int] = self.hasFootprintOfMonth
        
        for day in 0..<totalDays {
            if day < startDay {
                days.append(WalkRecordModel(day: String(), footprintNumber: 0))
                continue
            }
            
            days.append(WalkRecordModel(day: "\(day - startDay + 1)", footprintNumber: walkRecordNum[day]))
        }
        
        print("🚨 - getDays 함수 안")
        print(days)
        
        return days
    }
    
    func updateMonthTitle(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        let dateToString = dateFormatter.string(from: calendarDate)
        return dateToString
    }
    
    func setPrevMonth() {
        let calendarDate = calendar.date(byAdding: DateComponents(month: -1), to: calendarDate) ?? Date()
        
        self.calendarDate = calendarDate
        self.startDay = calendar.component(.weekday, from: calendarDate) - 1
        self.monthDays = calendar.range(of: .day, in: .month, for: calendarDate)!.count
    }
    
    func setNextMonth() {
        let calendarDate = calendar.date(byAdding: DateComponents(month: +1), to: calendarDate) ?? Date()
        
        self.calendarDate = calendarDate
        self.startDay = calendar.component(.weekday, from: calendarDate) - 1
        self.monthDays = calendar.range(of: .day, in: .month, for: calendarDate)!.count
    }
    
    /// 날짜별로 발자국 여부를 나타내주기 위한 함수
    /// 발자국이 없는 날은 0, 있는 날은 1로
    func getWalkRecordOfMonth(date: [WalkRecordResponseDTO]) -> [Int] {
        var walkRecordDate: [WalkRecordResponseDTO] = date
        var days = [Int](repeating: 0, count: monthDays)
        
        for (index, _) in days.enumerated() {
            if index + 1 == walkRecordDate.first?.day {
                days[index] = 1
                walkRecordDate.removeFirst()
            }
        }
        
        for _ in 0..<startDay {
            days.insert(0, at: 0)
        }
        
        return days
    }
}
