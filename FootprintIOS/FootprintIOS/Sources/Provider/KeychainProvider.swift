//
//  KeychainProvider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import SwiftKeychainWrapper

protocol KeychainProviderType {
    func getAccessToken() -> String
    func getRefreshToken() -> String
    
    func updateTokens(accessToken: String, refreshToken: String)
    func updateAccessToken(_ token: String)
    func updateRefreshToken(_ token: String)
    
    func deleteTokens()
    func deleteAccessToken()
    func deleteRefreshToken()
}

class KeychainProvider: BaseProvider, KeychainProviderType {
    private let keychain = KeychainWrapper.standard
    
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    func getAccessToken() -> String {
        return keychain.string(forKey: accessTokenKey) ?? ""
    }
    
    func getRefreshToken() -> String {
        return keychain.string(forKey: refreshTokenKey) ?? ""
    }
    
    func updateTokens(accessToken: String, refreshToken: String) {
        keychain.set(accessToken, forKey: accessTokenKey)
        keychain.set(refreshToken, forKey: refreshTokenKey)
    }
    
    func updateAccessToken(_ token: String) {
        keychain.set(token, forKey: accessTokenKey)
    }
    
    func updateRefreshToken(_ token: String) {
        keychain.set(token, forKey: refreshTokenKey)
    }
    
    func deleteTokens() {
        keychain.set("", forKey: accessTokenKey)
        keychain.set("", forKey: refreshTokenKey)
    }
    
    func deleteAccessToken() {
        keychain.set("", forKey: accessTokenKey)
    }
    
    func deleteRefreshToken() {
        keychain.set("", forKey: refreshTokenKey)
    }
}
