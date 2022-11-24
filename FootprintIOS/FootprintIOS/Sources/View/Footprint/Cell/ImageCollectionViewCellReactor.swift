//
//  ImageCollectionViewCellReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class ImageCollectionViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {}
    
    var initialState: State
    
    init() {
        initialState = State()
    }
}

extension ImageCollectionViewCellReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}
