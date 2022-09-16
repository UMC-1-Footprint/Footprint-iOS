//
//  NoticeSectionModel.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxDataSources

typealias NoticeSectionModel = SectionModel<NoticeSection, NoticeItem>

enum NoticeSection {
    case notice([NoticeItem])
}

enum NoticeItem {
    case notice(NoticeTableViewCellReactor)
}

extension NoticeSection: SectionModelType {
    typealias Item = NoticeItem
    
    var items: [Item] {
        switch self {
        case let .notice(items):
            return items
        }
    }
    
    init(original: NoticeSection, items: [NoticeItem]) {
        switch original {
        case let .notice(items):
            self = .notice(items)
        }
    }
}
