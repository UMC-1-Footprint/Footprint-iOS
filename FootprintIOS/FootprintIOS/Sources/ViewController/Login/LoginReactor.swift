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
                if let error = error {
                    print(error)
                }
                else {
                    guard let token = oauthToken else { return observable.onNext(.doKakaoLogin(false)) }
                    let keyChain = KeyChain()
                    keyChain.createKeyChain(key: token.accessToken, token: token.accessToken)
                    keyChain.createKeyChain(key: token.refreshToken, token: token.refreshToken)
                    observable.onNext(.doKakaoLogin(true))
                    observable.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func kakaoLoginWeb() -> Observable<Mutation> {
        return Observable<Mutation>.create { observable in
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    guard let token = oauthToken else { return observable.onNext(.doKakaoLogin(false)) }
                    let keyChain = KeyChain()
                    keyChain.createKeyChain(key: token.accessToken, token: token.accessToken)
                    keyChain.createKeyChain(key: token.refreshToken, token: token.refreshToken)
                    observable.onNext(.doKakaoLogin(true))
                    observable.onCompleted()
                    //TODO: - 여기까지 넣으면 제대로 처리가 안됨 .. .왤까요
//                    UserApi.shared.me {(user, error) in
//                        if let error = error {
//                            print(error)
//                        } else {
//                            let keyChain = KeyChain()
//                            guard let userEmail = user?.kakaoAccount?.email else { return }
//                            keyChain.createKeyChain(key: userEmail, token: token.accessToken)
//                            keyChain.createKeyChain(key: userEmail, token: token.refreshToken)
//                            print("성공했다구 넘길꼬임 ")
//                            observable.onNext(.doKakaoLogin(true))
//                        }
//                    }
                }
            }
            return Disposables.create()
        }
    }
}
