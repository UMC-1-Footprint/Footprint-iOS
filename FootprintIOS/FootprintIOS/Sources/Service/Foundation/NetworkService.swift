//
//  NetworkService.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

protocol NetworkServiceType {
    var API: API { get }
}

class NetworkService: NetworkServiceType {
    let API: API
    
    init(API: API) {
        self.API = API
    }
}
