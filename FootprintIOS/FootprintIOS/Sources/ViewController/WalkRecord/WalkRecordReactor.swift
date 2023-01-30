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
//        case detail(String)
    }
    
    enum Mutation {
        case setWalkRecordSection([WalkRecordSectionModel])
        case setCalendarMonthTitle(String)
        case setUpdateStatus(Bool)
//        case setCalendarSection([WalkRecordResponseDTO])
//        case setDetailSection([WalkRecordDetailResponseDTO])
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setWalkRecordSection(section):
            print("🔥 setWalkRecord")
            newState.walkRecordSection = section
        case let .setCalendarMonthTitle(month):
            newState.monthTitle = month
        case let .setUpdateStatus(status):
            newState.isUpdated = status
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
                    return .just(.setWalkRecordSection(self.createCalendarSection(model: self.getDays())))
                }
            })
        
        return Observable.merge(mutation, eventMutation)
    }
    
}

extension WalkRecordReactor {
    func refreshMutation() -> Observable<Mutation> {
        service.getNumber(year: calendarDate.year, month: calendarDate.month)
        service.getDetail(date: "2023-01-04")

        return Observable.concat([
            .just(.setCalendarMonthTitle(updateMonthTitle()))
        ])
    }
    
    func getPrevMonthMutation() -> Observable<Mutation> {
        setPrevMonth()
        
        let days = [Int](repeating: 0, count: totalDays) // TODO: - 서버에서 받는 값으로 수정
        
        return Observable.concat([
            .just(.setWalkRecordSection(createCalendarSection(model: getDays()))),
            .just(.setCalendarMonthTitle(updateMonthTitle()))
        ])
    }
    
    func getNextMonthMutation() -> Observable<Mutation> {
        setNextMonth()
        
        let days = [Int](repeating: 0, count: totalDays) // TODO: - 서버에서 받는 값으로 수정
        
        return Observable.concat([
            .just(.setWalkRecordSection(createCalendarSection(model: getDays()))),
            .just(.setCalendarMonthTitle(updateMonthTitle()))
        ])
    }
    
    func createCalendarSection(model: [WalkRecordModel]) -> [WalkRecordSectionModel] {
        // reactor 내부 변수에 저장해두고 이걸 사용하는 방식으로 착안 ??
        let calendarItems = model.map { item -> WalkRecordItem in
            return .calendar(item)
        }
        
        //detail 여기서 사용해야함
//        var recordItems:[WalkRecordItem] = []
        
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
    
    func updateMonthTitle() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월"
        let dateToString = dateFormatter.string(from: calendarDate)
        return dateToString
    }
    
    func setPrevMonth(){
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
