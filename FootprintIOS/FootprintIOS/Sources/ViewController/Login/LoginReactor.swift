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
            var loginStatus = false
            if (UserApi.isKakaoTalkLoginAvailable()) {
                loginStatus = self.kakaoLoginApp()
            }
            else {
                loginStatus = self.kakaoLoginWeb()
            }
            print("mutation 함수에서 동작 여부 :", loginStatus)
            return .just(.doKakaoLogin(loginStatus))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .doKakaoLogin(let status):
            print("mutation: ", status)
            newState.kakaoLoginButtonDidTap = status
        }
        
        return newState
    }
}

// MARK: - extension
extension LoginReactor {
    func kakaoLoginApp() -> Bool {
        var loginStatus = false
        
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                guard let token = oauthToken else { return }
                print("카카오 로그인 되는중 드릉드릉 드르릉")
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        let keyChain = KeyChain()
                        guard let userEmail = user?.kakaoAccount?.email else { return }
                        keyChain.createKeyChain(key: userEmail, token: token.accessToken)
                        keyChain.createKeyChain(key: userEmail, token: token.refreshToken)
                        print("성공했다구 넘길꼬임 ")
                        loginStatus = true
                    }
                }
            }
        }
        return loginStatus
    }
    
    func kakaoLoginWeb() -> Bool {
        var loginStatus = false
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                guard let token = oauthToken else { return }
                print("카카오 로그인 되는중 드릉드릉 드르릉")
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        let keyChain = KeyChain()
                        guard let userEmail = user?.kakaoAccount?.email else { return }
                        keyChain.createKeyChain(key: userEmail, token: token.accessToken)
                        keyChain.createKeyChain(key: userEmail, token: token.refreshToken)
                        print("성공했다구 넘길꼬임 ")
                        loginStatus = true
                    }
                }
            }
        }
        return loginStatus
    }
}
