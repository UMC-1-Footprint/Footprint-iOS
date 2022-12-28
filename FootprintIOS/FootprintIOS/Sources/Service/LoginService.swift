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
    case login(LoginResponseDTO)
}

protocol LoginServiceType {
    var event: PublishSubject<LoginEvent> { get }
    
    func login(userId: String, userName: String, userEmail: String, providerType: LoginProviderType)
}

class LoginService: NetworkService, LoginServiceType {
    var event = PublishSubject<LoginEvent>()
    
    func login(userId: String, userName: String, userEmail: String, providerType: LoginProviderType) {
        let request = LoginEndPoint
            .login(userId: userId, userName: userName, userEmail: userEmail, providerType: providerType)
            .createRequest()
        
        let response: Single<BaseModel<LoginResponseDTO>> = API.request(request: request)
        
        response.asObservable()
            .map(\.result)
            .bind { [weak self] data in
                self?.event.onNext(.login(data))
            }
            .disposed(by: disposeBag)
    }
}
