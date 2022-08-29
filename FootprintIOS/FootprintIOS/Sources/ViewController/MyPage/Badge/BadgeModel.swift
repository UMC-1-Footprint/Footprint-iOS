//
//  BadgeModel.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/08/29.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

struct BadgeModel {
    let badgeImage: UIImage
    let badgeTitle: String
}

extension BadgeModel {
    static let dummyData: [BadgeModel] = [
        BadgeModel(badgeImage: FootprintIOSAsset.Images.proBadge.image, badgeTitle: "프로발자국러"),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.startBadge.image, badgeTitle: "발자국 스타터"),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
        BadgeModel(badgeImage: FootprintIOSAsset.Images.emptyBadge.image, badgeTitle: ""),
    ]
}
