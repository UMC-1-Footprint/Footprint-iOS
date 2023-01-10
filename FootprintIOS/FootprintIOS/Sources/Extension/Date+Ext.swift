//
//  Date+Ext.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/15.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var weekday: String {
        let today = Calendar.current.component(.weekday, from: self)
        let days = ["", "일", "월", "화", "수", "목", "금", "토"]
        return days[today]
    }
    
    func getStringMonthList() -> [String] {
        let date = self
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        var monthList: [String] = .init()
        
        for i in 0...5 {
            let newMonth = month - (6-i)
            if newMonth <= 0 {
                monthList.append("\(newMonth + 12)월")
            } else {
                monthList.append("\(newMonth)월")
            }
        }
        monthList.append("이번달")
        return monthList
    }
    
    func calculateDate(type: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: type, value: value, to: self) ?? Date()
        return date
    }
    
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let string = dateFormatter.string(from: self)
        return string
    }
}
