//
//  KeyChain.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import SwiftKeychainWrapper
import RxSwift

enum KeychainEvent {
    case getAccessToken(token: String)
    case getRefreshToken(token: String)
    
    case updateTokens
    case updateAccessToken
    case updateRefreshToken
    
    case deleteTokens
    case deleteAccessToken
    case deleteRefreshToken
}

protocol KeychainServiceType {
    var event: PublishSubject<KeychainEvent> { get }
    
    func updateTokens(accessToken: String, refreshToken: String)
    func updateAccessToken(token: String)
    func updateRefreshToken(token: String)
    
    func deleteTokens()
    func deleteAccessToken()
    func deleteRefreshToken()
}

class KeychainService: LocalService, KeychainServiceType {
    var event = PublishSubject<KeychainEvent>()
    
    func updateTokens(accessToken: String, refreshToken: String) {
        provider.Keychain.updateTokens(accessToken: accessToken, refreshToken: refreshToken)
        
        event.onNext(.updateTokens)
    }
    
    func updateAccessToken(token: String) {
        provider.Keychain.updateAccessToken(token)
        
        event.onNext(.updateAccessToken)
    }
    
    func updateRefreshToken(token: String) {
        provider.Keychain.updateRefreshToken(token)
        
        event.onNext(.updateRefreshToken)
    }
    
    func deleteTokens() {
        provider.Keychain.deleteTokens()
        
        event.onNext(.deleteTokens)
    }
    
    func deleteAccessToken() {
        provider.Keychain.deleteAccessToken()
        
        event.onNext(.deleteAccessToken)
    }
    
    func deleteRefreshToken() {
        provider.Keychain.deleteRefreshToken()
        
        event.onNext(.deleteRefreshToken)
    }
}
