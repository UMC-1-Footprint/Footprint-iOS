//
//  monthRoundChartView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class monthRoundChartView: BaseView {
    
    // MARK: - Properties
    
    var percent: Int
    
    // MARK: - Initializer
    
    init(percent: Int) {
        self.percent = percent
        
        super.init(frame: .zero)
    }
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .systemGray6
        
        print(#function)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        
        let width = self.frame.width
        let height = self.frame.height
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2),
                                           radius: 32,
                                           startAngle: 0,
                                           endAngle: 360,
                                           clockwise: true)
        FootprintIOSAsset.Colors.whiteD.color.setStroke()
        progressPath.lineWidth = 5
        progressPath.stroke()
        
        let percentAngle = (percent) * 360 / 100
        let endAngle = (CGFloat(percentAngle) / 360) * (.pi * 2)
        
        let progressBarPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2),
                                           radius: 32,
                                           startAngle: (-(.pi) / 2),
                                           endAngle: (-(.pi) / 2) + endAngle,
                                           clockwise: true)
        FootprintIOSAsset.Colors.blueM.color.setStroke()
        progressBarPath.lineWidth = 5
        progressBarPath.lineCapStyle = .round
        progressBarPath.stroke()
    }
}
