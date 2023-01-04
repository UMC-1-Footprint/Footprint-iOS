//
//  Enviroment.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol EnvironmentProviderType: AnyObject {
    var version: String { get }
    var url: String { get }
    var kakaoAppKey: String { get }
}

class EnvironmentProvider: BaseProvider, EnvironmentProviderType {
    var version: String {
        FootprintIOSResources.bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var url: String {
        FootprintIOSResources.bundle.object(forInfoDictionaryKey: "API_BASE_URL") as! String
    }
    
    var kakaoAppKey: String {
        FootprintIOSResources.bundle.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as! String
    }
}
