//
//  FootprintService.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

enum FootprintEvent {
    case saveFootprint
}

protocol FootprintServiceType {
    var event: PublishSubject<FootprintEvent> { get }
    
    func saveFootprint()
}


class FootprintService: LocalService, FootprintServiceType {
    var event = PublishSubject<FootprintEvent>()
    
    func saveFootprint() {
        event.onNext(.saveFootprint)
    }
}
