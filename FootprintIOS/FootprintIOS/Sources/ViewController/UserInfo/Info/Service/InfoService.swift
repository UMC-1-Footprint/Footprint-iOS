//
//  InfoService.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxSwift

enum InfoEvent {
    case updateBirth(String)
}

protocol InfoServiceProtocol {
    var event: PublishSubject<InfoEvent> { get }
    
    func updateBirth(to birth: String) -> Observable<String>
}

class InfoService: InfoServiceProtocol {
    let event = PublishSubject<InfoEvent>()
    
    func updateBirth(to birth: String) -> Observable<String> {
        event.onNext(.updateBirth(birth))
        return .just(birth)
    }
}
