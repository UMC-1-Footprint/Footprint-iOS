//
//  FootprintRecordReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class FootprintMapReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {}
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}
