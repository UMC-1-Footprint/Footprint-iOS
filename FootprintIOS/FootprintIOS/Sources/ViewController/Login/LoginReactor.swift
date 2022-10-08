//
//  LoginReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

import ReactorKit
import KakaoSDKUser

class LoginReactor: Reactor {
    enum Action {
        case kakaoLogin
    }
    
    enum Mutation {
        case doKakaoLogin(Bool)
    }
    
    struct State {
        var kakaoLoginButtonDidTap: Bool = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .kakaoLogin:
            if (UserApi.isKakaoTalkLoginAvailable()) {
                return kakaoLoginApp()
            }
            else {
                return kakaoLoginWeb()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .doKakaoLogin(let status):
            newState.kakaoLoginButtonDidTap = status
        }
        
        return newState
    }
}

// MARK: - extension
extension LoginReactor {
    func kakaoLoginApp() -> Observable<Mutation> {
        return Observable<Mutation>.create { observable in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                guard let token = oauthToken else { return observable.onNext(.doKakaoLogin(false)) }
                if let error = error {
                    print(error)
                }
                else {
                    UserApi.shared.me {(user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            guard let userEmail = user?.kakaoAccount?.email else { return observable.onNext(.doKakaoLogin(false)) }
                            let keyChain = KeyChain()
                            keyChain.createKeyChain(key: userEmail, token: token.accessToken)
                            keyChain.createKeyChain(key: userEmail, token: token.refreshToken)
                            observable.onNext(.doKakaoLogin(true))
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func kakaoLoginWeb() -> Observable<Mutation> {
        return Observable<Mutation>.create { observable in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                guard let token = oauthToken else { return observable.onNext(.doKakaoLogin(false)) }
                if let error = error {
                    print(error)
                } else {
                    UserApi.shared.me {(user, error) in
                        if let error = error {
                            print(error)
                        } else {
                            guard let userEmail = user?.kakaoAccount?.email else { return observable.onNext(.doKakaoLogin(false)) }
                            let keyChain = KeyChain()
                            keyChain.createKeyChain(key: userEmail, token: token.accessToken)
                            keyChain.createKeyChain(key: userEmail, token: token.refreshToken)
                            observable.onNext(.doKakaoLogin(true))
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
