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
        case text(String)
        case uploadImage([UIImage])
    }
    
    enum Mutation {
        case setSections([ImageSectionModel])
        case setText(String)
        case setImages([UIImage])
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
        case let .text(text):
            return .just(.setText(text))
            
        case let .uploadImage(images):
            return .concat([
                .just(.setImages(images)),
                .just(.setSections(makeSections(from: images)))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setSections(sections):
            newState.sections = sections
            
        case let .setText(text):
            newState.text = text
            
        case let .setImages(images):
            newState.images = images
        }
        
        return newState
    }
    
    private func makeSections(from images: [UIImage]) -> [ImageSectionModel] {
        let items: [ImageItem] = images.map({ (image) -> ImageItem in
            return .image(.init(image: image))
        })
        let section: ImageSectionModel = .init(model: .image(items), items: items)
        
        return [section]
    }
}
