//
//  LoginManager.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

enum LoginEvent {
    case login(LoginResponseModel)
}

protocol LoginServiceType {
    var event: PublishSubject<LoginEvent> { get }
    
    func loginAPI(userId: String, userName: String, userEmail: String, providerType: ProviderType) -> Observable<BaseModel<LoginResponseModel>>
}

class LoginService: NetworkService, LoginServiceType {
    var event = PublishSubject<LoginEvent>()
    
    func loginAPI(userId: String, userName: String, userEmail: String, providerType: ProviderType) -> Observable<BaseModel<LoginResponseModel>> {
        let request = LoginEndPoint
            .login(userId: userId, userName: userName, userEmail: userEmail, providerType: providerType)
            .createRequest()

        return API.request(request: request)
    }
}

