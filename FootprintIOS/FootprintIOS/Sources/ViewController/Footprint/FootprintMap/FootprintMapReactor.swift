//
//  FootprintRecordReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import ReactorKit
import CoreLocation

class FootprintMapReactor: Reactor {
    enum Action {
        case move(CLLocationCoordinate2D)
    }
    
    enum Mutation {
        case appendLocation(CLLocationCoordinate2D)
        case appendMarker(CLLocationCoordinate2D)
    }
    
    struct State {
        var locations: [CLLocationCoordinate2D] = []
        var markers: [CLLocationCoordinate2D] = []
    }
    
    var initialState: State
    let footprintService: FootprintServiceType
    
    init(state: State, footprintService: FootprintServiceType) {
        self.initialState = state
        self.footprintService = footprintService
    }
}

extension FootprintMapReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .move(location):
            return .just(.appendLocation(location))
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let event = footprintService.event.flatMap { [weak self] (event) -> Observable<Mutation> in
            switch event {
            case .saveFootprint:
                if let location = self?.currentState.locations.last {
                    return .just(.appendMarker(location))
                } else {
                    return .empty()
                }
            }
        }
        
        return Observable.merge(event, mutation)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .appendLocation(location):
            newState.locations.append(location)
            
        case let .appendMarker(location):
            newState.markers.append(location)
        }
        
        return newState
    }
}
