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
}

protocol WalkRecordServiceType {
    var event: PublishSubject<WalkRecordEvent> { get }
    
    func getNumber(year: Int, month: Int)
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
    }
}
