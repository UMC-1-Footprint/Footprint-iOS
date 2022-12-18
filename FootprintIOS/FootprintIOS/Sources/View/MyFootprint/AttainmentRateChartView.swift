//
//  AttainmentRateChartView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/31.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class AttainmentRateChartView: BaseView {
    let percentageLabel: UILabel = .init()
    var percentage: String = .init()
    var keyColor: UIColor
    var percentageAngle: Int
    
    init(keyColor: UIColor, percentageAngle: Int) {
        self.keyColor = keyColor
        self.percentageAngle = percentageAngle
        
        super.init(frame: .zero)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        self.backgroundColor = .white
        percentageLabel.text = String(percentageAngle) + "%"
        percentageLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        percentageLabel.textColor = keyColor
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        percentageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(percentageLabel)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        
        let width = self.frame.width
        let height = self.frame.height
        
        let endAnglePercentage = percentageAngle *  360 / 100
        let endAngle = ( CGFloat(endAnglePercentage) / 360 ) * (CGFloat.pi * 2)
        
        let inlinePath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height/2), radius: 40, startAngle: 0, endAngle: 360, clockwise: true)
        FootprintIOSAsset.Colors.whiteM.color.set()
        inlinePath.lineWidth = 8
        inlinePath.stroke()
        
        let outlinePath = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: 40, startAngle: (-(.pi) / 2), endAngle: (-(.pi) / 2) + endAngle, clockwise: true)
        outlinePath.lineWidth = 8
        outlinePath.lineCapStyle = .round
        keyColor.set()
        outlinePath.stroke()
    }
}
