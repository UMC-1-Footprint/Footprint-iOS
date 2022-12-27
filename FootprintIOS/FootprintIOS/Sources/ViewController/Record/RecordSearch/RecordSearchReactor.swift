//
//  RecordSearchReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit

class RecordSearchReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setSections([RecordSearchSectionModel])
    }
    
    struct State {
        var sections: [RecordSearchSectionModel] = []
    }
    
    var initialState: State
    let walkService: WalkServiceType
    
    init(id: Int, walkService: WalkServiceType) {
        self.initialState = State()
        
        self.walkService = walkService
    }
}

extension RecordSearchReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refreshSections()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSections(sections):
            newState.sections = sections
        }
        
        return newState
    }
    
    func refreshSections() -> Observable<Mutation> {
        return .just(.setSections(makeSections()))
    }
    
    
    //TODO: 서버 통신 후 로직 변경
    private func makeSections() -> [RecordSearchSectionModel] {
        var items: [RecordSearchItem] = []
        items.append(.record(.init()))
        items.append(.record(.init()))
        items.append(.record(.init()))
        let section: RecordSearchSectionModel = .init(model: .record(items), items: items)
        return [section]
    }
}
