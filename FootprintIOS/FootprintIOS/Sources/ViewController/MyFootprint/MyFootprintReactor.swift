//
//  MyFootprintReactor.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2023/01/22.
//  Copyright © 2023 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class MyFootprintReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setInfos(MyFootprintInfosResponseDTO)
    }
    
    struct State {
        var infos: MyFootprintInfosResponseDTO?
    }
    
    let initialState: State
    let service: MyFootprintInfosServiceType
    
    init(service: MyFootprintInfosServiceType) {
        self.initialState = State()
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            service.get()
            
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setInfos(data):
            newState.infos = data
        }
        
        return newState
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = service.event
            .flatMap({ (event) -> Observable<Mutation> in
                switch event {
                case let .get(result):
                    return .just(.setInfos(result))
                }
            })
        
        return Observable.merge(mutation, eventMutation)
    }
}
