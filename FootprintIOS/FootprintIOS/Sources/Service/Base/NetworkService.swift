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
    var API: APIProviderType { get }
}

class NetworkService: BaseService, NetworkServiceType {
    let API = Provider.shared.API
}
