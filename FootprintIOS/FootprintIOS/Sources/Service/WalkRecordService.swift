//
//  WalkRecordService.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/10.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

enum WalkRecordEvent {
    case getNumber([WalkRecordResponseDTO])
    case getDetail([WalkRecordDetailResponseDTO])
}

protocol WalkRecordServiceType {
    var event: PublishSubject<WalkRecordEvent> { get }
    
    func getNumber(year: Int, month: Int)
    func getDetail(date: String)
}

class WalkRecordService: NetworkService, WalkRecordServiceType {
    var event = PublishSubject<WalkRecordEvent>()
    
    func getNumber(year: Int, month: Int) {
        let request = WalkRecordEndPoint
            .getNumber(year: year, month: month)
            .createRequest()
        
        let response: Single<BaseModel<[WalkRecordResponseDTO]>> = API.request(request: request)
                
        response.asObservable()
            .map(\.result)
            .bind { [weak self] data in
                self?.event.onNext(.getNumber(data))
            }
            .disposed(by: disposeBag)
        
//        return response
//            .asObservable()
//            .map(\.result)
    }
    
    func getDetail(date: String) {
        let request = WalkRecordEndPoint
            .getDetail(date: date)
            .createRequest()
        
        let response: Single<BaseModel<[WalkRecordDetailResponseDTO]>> = API.request(request: request)

        response.asObservable()
            .map(\.result)
            .bind { [weak self] result in
                print("🚨 디테일 가져오는 함수")
                print("🚨 response - \(result)")
                self?.event.onNext(.getDetail(result))
            }
            .disposed(by: disposeBag)
        
//        return response.asObservable()
//            .map(\.result)
    }
}
