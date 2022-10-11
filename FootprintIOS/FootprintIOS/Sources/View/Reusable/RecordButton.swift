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
            return FootprintIOSAsset.Images.footBigLogo.image.withTintColor(.white)
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
        
        setImage(type.image, for: .normal)
        makeBorder(color: FootprintIOSAsset.Colors.blueM.color, width: 4)
        
        switch type {
        case .stop, .save:
            backgroundColor = .white
            cornerRound(radius: 32)
        case .footprint:
            backgroundColor = FootprintIOSAsset.Colors.blueM.color
            cornerRound(radius: 35)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
