//
//  BarGraphView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.

//  마이페이지 - 그래프 : 막대 그래프 

import UIKit

import SnapKit

class BarGraphView: BaseView {
    let percentage: Int
    let backgroundGraphView = UIView()
    lazy var mainGraphView = UIView()
    
    init(percentage: Int) {
        self.percentage = percentage
        
        super.init(frame: .zero)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        let parentHeight: Int = 125
        let childHeight: CGFloat = CGFloat(parentHeight * percentage / 100)
        
        backgroundGraphView.snp.makeConstraints {
            $0.width.equalTo(10)
            $0.height.equalTo(125)
            $0.edges.equalToSuperview()
        }
        
        mainGraphView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(childHeight)
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        mainGraphView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        }
    }
    
    override func setupHierarchy() {
        backgroundGraphView.addSubview(mainGraphView)
        addSubview(backgroundGraphView)
    }
}
