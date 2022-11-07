//
//  UnderLineView.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit

class UnderLineView: BaseView {
    let view: UIView = .init()
    
    override func setupProperty() {
        view.backgroundColor = FootprintIOSAsset.Colors.white4.color
    }
    
    override func setupLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        addSubview(view)
    }
}
