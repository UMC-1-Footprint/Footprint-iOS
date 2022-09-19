//
//  TestManager.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/09/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

struct TestManager {
    let apiService: TestAPIManager
    let environment: APIEnvironment
    
    init(apiService: TestAPIManager, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getTestAPI() -> Observable<[TestModel]?> {
        let request = TestEndPoint
            .testAPI
            .createRequest(environment: .test)
        return self.apiService.request(request)
    }
    
//    func getTestAPI() -> Observable<[TestModel]?> {
//        let request = TestEndPoint
//            .testAPI
//            .createRequest(environment: .test)
//        return apiService.request(request)
////        return try await self.apiService.request(request)
//    }
    
}
