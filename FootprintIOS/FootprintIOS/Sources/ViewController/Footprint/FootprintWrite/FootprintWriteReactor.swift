//
//  FootprintWriteReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class FootprintWriteReactor: Reactor {
    enum Action {
        case refresh
        case editText(String)
        case resetPicker
        case pickImage(UIImage)
    }
    
    enum Mutation {
        case setSections([ImageSectionModel])
        case addImage(UIImage)
        case updateText(String)
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

        case let .editText(text):
            return .just(.updateText(text))
            
        case let .pickImage(image):
            return pickImagesMutation(image)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSections(sections):
            newState.sections = sections
            
        case let .updateText(text):
            newState.text = text
        }
        
        return newState
    }
    
    private func refreshMutation() -> Observable<Mutation> {
        return .empty()
    }
    
    private func pickImagesMutation(_ image: UIImage) -> Observable<Mutation> {
        return .just(.set)
        return .just(.setSections(makeSections(from: images)))
    }
    
    private func makeSections(from images: [UIImage]) -> [ImageSectionModel] {
        let items: [ImageItem] = images.map({ (image) -> ImageItem in
            return .image(.init())
        })
        let section: ImageSectionModel = .init(model: .image(items), items: items)
        return [section]
    }
}
