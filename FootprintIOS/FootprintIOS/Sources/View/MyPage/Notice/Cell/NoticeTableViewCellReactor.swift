//
//  NoticeTableViewCellReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class NoticeTableViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {}
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}
