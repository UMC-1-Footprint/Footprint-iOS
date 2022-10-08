//
//  RecordViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import NMapsMap

class RecordViewController: NavigationBarViewController {
    let mapView: NMFMapView = .init()
    
    override func setupProperty() {
        super.setupProperty()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([mapView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
