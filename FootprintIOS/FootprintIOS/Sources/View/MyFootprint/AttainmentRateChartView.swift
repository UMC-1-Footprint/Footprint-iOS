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
    var petcentageAngle: Int
    
    init(keyColor: UIColor, petcentageAngle: Int) {
        self.keyColor = keyColor
        self.petcentageAngle = petcentageAngle
        
        super.init(frame: .zero)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        self.backgroundColor = .white
        percentageLabel.text = String(petcentageAngle) + "%"
        percentageLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        percentageLabel.textColor = keyColor
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        percentageLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(percentageLabel)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        
        let endAnglePercentage = petcentageAngle *  360 / 100
        let endAngle = ( CGFloat(endAnglePercentage) / 360 ) * (CGFloat.pi * 2)
        
        let inlinePath = UIBezierPath(ovalIn: CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height-20))
        inlinePath.lineWidth = 8
        FootprintIOSAsset.Colors.whiteM.color.set()
        inlinePath.stroke()
        
        let outlinePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: 40, startAngle: (-(.pi) / 2), endAngle: (-(.pi) / 2) + endAngle, clockwise: true)
        outlinePath.lineWidth = 8
        outlinePath.lineCapStyle = .round
        keyColor.set()
        outlinePath.stroke()
    }
}
