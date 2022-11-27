//
//  ImageCollectionViewCellReactor.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit

class ImageCollectionViewCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        var image: UIImage
    }
    
    var initialState: State
    
    init(image: UIImage) {
        initialState = State(image: image)
    }
}

