//
//  SearchCollectionViewCellReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class SearchCollectionViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State{}
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}
