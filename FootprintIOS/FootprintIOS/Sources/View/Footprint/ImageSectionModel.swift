//
//  ImageSectionModel.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxDataSources

typealias ImageSectionModel = SectionModel<ImageSection, ImageItem>

enum ImageSection {
    case image([ImageItem])
}

enum ImageItem {
    case image(ImageCollectionViewCellReactor)
}

extension ImageSection: SectionModelType {
    typealias Item = ImageItem
    
    var items: [Item] {
        switch self {
        case let .image(items):
            return items
        }
    }
    
    init(original: ImageSection, items: [ImageItem]) {
        switch original {
        case let .image(items):
            self = .image(items)
        }
    }
}

