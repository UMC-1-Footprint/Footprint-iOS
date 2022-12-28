//
//  BaseService.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseServiceType {
    var disposeBag: DisposeBag { get }
}

class BaseService: BaseServiceType {
    var disposeBag: DisposeBag = .init()
    
    init() {
        
    }
}
