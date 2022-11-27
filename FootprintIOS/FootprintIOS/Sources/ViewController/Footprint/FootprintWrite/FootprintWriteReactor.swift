//
//  FootprintWriteReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit
import PhotosUI

class FootprintWriteReactor: Reactor {
    enum Action {
        case refresh
        case text(String)
        case resolve
        case resolving(UIImage)
        case resolved
    }
    
    enum Mutation {
        case setSections([ImageSectionModel])
        case setText(String)
        case appendImage(UIImage)
        case resetImage
    }
    
    struct State {
        var sections: [ImageSectionModel] = []
        var images: [UIImage] = []
        var text: String = ""
    }
    
    var initialState: State
    
    init(state: State) {
        self.initialState = state
    }
}

extension FootprintWriteReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return refreshMutation()

        case let .text(text):
            return textMutation(text)
            
        case .resolve:
            return resolveMutation()
            
        case let .resolving(image):
            return resolvingMutation(image)
            
        case .resolved:
            return resolved()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSections(sections):
            newState.sections = sections
            
        case let .setText(text):
            newState.text = text
            
        case let .appendImage(image):
            newState.images.append(image)
            
        case .resetImage:
            newState.images.removeAll()
        }
        
        return newState
    }
    
    private func refreshMutation() -> Observable<Mutation> {
        return .empty()
    }
    
    private func textMutation(_ text: String) -> Observable<Mutation> {
        return .just(.setText(text))
    }
    
    private func resolveMutation() -> Observable<Mutation> {
        return .just(.resetImage)
    }
    
    private func resolvingMutation(_ image: UIImage) -> Observable<Mutation> {
        return .just(.appendImage(image))
    }
    
    private func resolved() -> Observable<Mutation> {
        return .just(.setSections(makeSections(from: currentState.images)))
    }
    
    private func makeSections(from images: [UIImage]) -> [ImageSectionModel] {
        let items: [ImageItem] = images.map({ (image) -> ImageItem in
            return .image(.init(image: image))
        })
        let section: ImageSectionModel = .init(model: .image(items), items: items)
        
        return [section]
    }
}
