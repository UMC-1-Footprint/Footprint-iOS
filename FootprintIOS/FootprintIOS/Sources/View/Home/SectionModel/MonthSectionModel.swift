//
//  MonthSectionModel.swift
//  Footprint-iOSTests
//
//  Created by 김영인 on 2022/11/04.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxDataSources

typealias MonthSectionModel = SectionModel<MonthSection, MonthItem>

enum MonthSection {
    case month([MonthItem])
}

enum MonthItem {
    case month(MonthCollectionViewCellReactor)
}

extension MonthSection: SectionModelType {
    typealias Item = MonthItem
    
    var items: [Item] {
        switch self {
        case let .month(items):
            return items
        }
    }
    
    init(original: MonthSection, items: [MonthItem]) {
        switch original {
        case let .month(items):
            self = .month(items)
        }
    }
}
