//
//  InfosService.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

enum MyFootprintInfosEvent {
    case get(MyFootprintInfosResponseDTO)
}

protocol MyFootprintInfosServiceType {
    var event: PublishSubject<MyFootprintInfosEvent> { get }
    
    func get()
}

class MyFootprintInfosService: NetworkService, MyFootprintInfosServiceType {
    var event = PublishSubject<MyFootprintInfosEvent>()
    
    func get() {
        let request = MyFootprintInfosEndPoint.get
            .createRequest()
        
        let response: Single<BaseModel<MyFootprintInfosResponseDTO>> = API.request(request: request)
        
        response.asObservable()
            .map(\.result)
            .bind { [weak self] result in
                self?.event.onNext(.get(result))
            }
            .disposed(by: disposeBag)
    }
}
