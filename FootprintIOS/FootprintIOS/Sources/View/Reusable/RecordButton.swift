//
//  RecordButton.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/10/11.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

enum RecordButtonType {
    case stop
    case footprint
    case save
    
    var image: UIImage {
        switch self {
        case .stop:
            return FootprintIOSAsset.Images.iconStop.image
        case .footprint:
            return FootprintIOSAsset.Images.iconLogo.image
        case .save:
            return FootprintIOSAsset.Images.iconSave.image
        }
    }
}

class RecordButton: UIButton {
    
    // MARK: - Properties
    
    let type: RecordButtonType
    
    // MARK: - Initializer
    
    init(type: RecordButtonType) {
        self.type = type
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
