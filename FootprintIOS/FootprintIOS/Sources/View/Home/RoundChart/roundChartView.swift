//
//  roundChartView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/11/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class roundChartView: BaseView {
    
    // MARK: - Properties
    
    var percent: Int
    var lineWidth: CGFloat
    var radius: CGFloat
    
    // MARK: - Initializer
    
    init(percent: Int, lineWidth: CGFloat, radius: CGFloat) {
        self.percent = percent
        self.lineWidth = lineWidth
        self.radius = radius
        
        super.init(frame: .zero)
    }
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .systemBackground
    }

    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        
        let width = self.frame.width
        let height = self.frame.height
        
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2),
                                           radius: radius,
                                           startAngle: 0,
                                           endAngle: 360,
                                           clockwise: true)
        FootprintIOSAsset.Colors.whiteD.color.setStroke()
        progressPath.lineWidth = lineWidth
        progressPath.stroke()
        
        let percentAngle = (percent) * 360 / 100
        let endAngle = (CGFloat(percentAngle) / 360) * (.pi * 2)
        
        let progressBarPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2),
                                           radius: radius,
                                           startAngle: (-(.pi) / 2),
                                           endAngle: (-(.pi) / 2) + endAngle,
                                           clockwise: true)
        FootprintIOSAsset.Colors.blueM.color.setStroke()
        progressBarPath.lineWidth = lineWidth
        progressBarPath.lineCapStyle = .round
        progressBarPath.stroke()
    }
}
