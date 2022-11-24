//
//  LineGraphView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then

class LineGraphView: BaseView {
    var graphLayer = CAShapeLayer()
    var path = UIBezierPath()
    
    var values:[CGFloat] = .init()
    
    init(values: [CGFloat]) {
        self.values = values
        
        super.init(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.addSublayer(graphLayer)
        
        let xOffset: CGFloat = self.frame.width / (CGFloat(values.count) - 1)
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x: currentX, y: getHeight(point: 0))
        
        self.path.move(to: startPosition)
        
        for i in 0..<values.count {
            if i == 0 {
                currentX = 0
            } else {
                currentX += xOffset
            }
            let newPosition = CGPoint(x: currentX,
                                      y: getHeight(point: i))
            self.path.addLine(to: newPosition)
        }
        
        graphLayer.fillColor = nil
        graphLayer.strokeColor = FootprintIOSAsset.Colors.blueM.color.cgColor
        graphLayer.lineWidth = 5
        graphLayer.path = path.cgPath
        graphLayer.lineCap = .round
        
        self.layer.addSublayer(graphLayer)
    }
}

extension LineGraphView {
    func getHeight(point: Int) -> CGFloat {
        let height = self.frame.height - (self.values[point] / 50) * 125
        return height
    }
}
