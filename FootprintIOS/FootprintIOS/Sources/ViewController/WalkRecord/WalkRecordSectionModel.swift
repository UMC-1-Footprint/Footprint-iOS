//
//  WalkRecordSectionModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

import RxDataSources

typealias WalkRecordSectionModel = SectionModel<WalkRecordSection, WalkRecordItem>

enum WalkRecordSection {
    case calendar([WalkRecordItem])
    case walkSummary([WalkRecordItem])
}

enum WalkRecordItem {
    case calendar(String)
    case walkSummary(RecordCollectionViewCellReactor)
//    case emptyWalkSummary
}

extension WalkRecordSection: SectionModelType {
    typealias Item = WalkRecordItem
    
    var items: [Item] {
        switch self {
        case let .calendar(items):
            return items
        case let .walkSummary(items):
            return items
        }
    }
    
    init(original: WalkRecordSection, items: [WalkRecordItem]) {
        switch original {
        case let .calendar(items):
            self = .calendar(items)
        case let .walkSummary(items):
            self = .walkSummary(items)
        }
    }
}
