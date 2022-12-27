//
//  KeyChain.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import SwiftKeychainWrapper

class KeychainService {
    static var shared = KeychainService()

    private init() {}

    private let keychain = KeychainWrapper.standard
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    var accessToken: String {
        get {
            return keychain.string(forKey: accessTokenKey) ?? ""
        }
        set {
            keychain.set(newValue, forKey: accessTokenKey)
        }
    }

    var refreshToken: String {
        get {
            return keychain.string(forKey: refreshTokenKey) ?? ""
        }
        set {
            keychain.set(newValue, forKey: refreshTokenKey)
        }
    }

    func removeAll() {
        accessToken = ""
        refreshToken = ""
    }

}

