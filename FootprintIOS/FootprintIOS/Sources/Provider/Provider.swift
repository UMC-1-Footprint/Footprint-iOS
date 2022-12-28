//
//  Provider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol ProviderType: AnyObject {
    var API: APIProviderType { get }
    var Enviroment: EnvironmentProviderType { get }
    var Keychain: KeychainProviderType { get }
}

class Provider: ProviderType {
    static let shared: ProviderType = Provider()
    
    lazy var API: APIProviderType = APIProvider(provider: self)
    lazy var Enviroment: EnvironmentProviderType = EnvironmentProvider(provider: self)
    lazy var Keychain: KeychainProviderType = KeychainProvider(provider: self)
    
    private init() {}
}
