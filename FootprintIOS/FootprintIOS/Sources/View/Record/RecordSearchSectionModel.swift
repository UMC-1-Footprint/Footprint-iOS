//
//  RecordSearchSectionModel.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxDataSources

typealias RecordSearchSectionModel = SectionModel<RecordSearchSection, RecordSearchItem>

enum RecordSearchSection {
    case search([RecordSearchItem])
    case record([RecordSearchItem])
}

enum RecordSearchItem {
    case search
    case record
}

extension RecordSearchSection: SectionModelType {
    typealias Item = RecordSearchItem
    
    var items: [Item] {
        switch self {
        case let .search(items):
            return items
            
        case let .record(items):
            return items
        }
    }
    
    init(original: RecordSearchSection, items: [RecordSearchItem]) {
        switch original {
        case let .search(items):
            self = .search(items)
            
        case let .record(items):
            self = .record(items)
        }
    }
}

