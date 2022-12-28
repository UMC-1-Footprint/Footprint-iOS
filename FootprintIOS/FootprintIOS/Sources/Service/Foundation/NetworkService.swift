//
//  NetworkService.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkServiceType {
    var disposeBag: DisposeBag { get }
    var API: API { get }
}

class NetworkService: NetworkServiceType {
    let disposeBag: DisposeBag = .init()
    let API: API
    
    init(API: API) {
        self.API = API
    }
}
