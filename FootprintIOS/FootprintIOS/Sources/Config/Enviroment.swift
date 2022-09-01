//
//  Enviroment.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

class Enviroment {
    static var version: String {
        FootprintIOSResources.bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
