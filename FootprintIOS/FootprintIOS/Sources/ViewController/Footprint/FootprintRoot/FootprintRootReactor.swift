//
//  FootprintMapReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import ReactorKit

class FootprintRootReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    var initialState: State
    
    let footprintService: FootprintServiceType
    
    init(state: State, footprintService: FootprintServiceType) {
        self.initialState = state
        self.footprintService = footprintService
    }
}
