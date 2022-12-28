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
    
    func login(userId: String, userName: String, userEmail: String, providerType: LoginProviderType) -> Observable<BaseModel<LoginResponseDTO>>
}

class LoginService: NetworkService, LoginServiceType {
    var event = PublishSubject<LoginEvent>()
    
    func login(userId: String, userName: String, userEmail: String, providerType: LoginProviderType) -> Observable<BaseModel<LoginResponseDTO>> {
//        let target = JourneyAPI.updatePikis(journeyId: journeyId, request: request)
//
//        let request = APIService.request(target: target)
//            .map(BaseModel<UpdatePikisResponse>.self)
//            .map(\.data.ids)
//            .asObservable()
//
//        request.bind { [weak self] ids in
//            self?.event.onNext(.updatePikis(ids: ids))
//        }
//        .disposed(by: disposeBag)
        
        
        let request = LoginEndPoint
            .login(userId: userId, userName: userName, userEmail: userEmail, providerType: providerType)
            .createRequest()
        
        return API.request(request: request)
        
//        API.request(request: request)
//            .map(BaseModel<LoginResponseDTO>.self)
        
//        return API.request(request: request)
    }
    
//    func loginAPI(userId: String, userName: String, userEmail: String, providerType: ProviderType) -> Observable<BaseModel<LoginResponseModel>> {
//
//
//        return API.request(request: request)
//    }
}

