//
//  NoticeReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class NoticeReactor: Reactor {
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setSections([NoticeSectionModel])
    }
    
    struct State {
        var sections: [NoticeSectionModel] = []
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}

extension NoticeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .just(.setSections(makeSections()))
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
    
    func makeSections() -> [NoticeSectionModel] {
        let items = [0, 1, 2, 3, 4, 5, 6, 7].map({ (i) -> NoticeItem in
            return .notice(NoticeTableViewCellReactor(state: .init()))
        })
        
        let section = NoticeSectionModel.init(model: .notice(items), items: items)
        
        return [section]
    }
}
