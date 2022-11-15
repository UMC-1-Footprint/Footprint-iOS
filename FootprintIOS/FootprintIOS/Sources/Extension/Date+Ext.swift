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
}
