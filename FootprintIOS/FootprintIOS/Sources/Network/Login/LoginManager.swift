//
//  LoginManager.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

struct LoginManager {
    let apiService: APIManager
    
    init(apiService: APIManager) {
        self.apiService = apiService
    }
    
    func loginAPI(userId: String, userName: String, userEmail: String, providerType: ProviderType) -> Observable<BaseModel<LoginResponseModel>> {
        let request = LoginEndPoint
            .login(userId: userId, userName: userName, userEmail: userEmail, providerType: providerType)
            .createRequest()
        return self.apiService.request(request: request)
    }
}
