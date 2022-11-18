//
//  AttainmentPercentageView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then

class AttainmentPercentageView: BaseView {
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    let endPoint: Int
    let increasementPoint: Int
    
    init(endPoint: Int, increasementPoint: Int) {
        self.endPoint = endPoint
        self.increasementPoint = increasementPoint
        
        super.init(frame: .zero)
    }
    
    override func setupLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        for i in stride(from: endPoint, to: -increasementPoint, by: -increasementPoint) {
            let label: UILabel = .init()
            label.text = "\(i)"
            label.font = .systemFont(ofSize: 10, weight: .light)
            label.textColor = FootprintIOSAsset.Colors.blackL.color
            
            stackView.addArrangedSubview(label)
        }

        addSubview(stackView)
    }
}
