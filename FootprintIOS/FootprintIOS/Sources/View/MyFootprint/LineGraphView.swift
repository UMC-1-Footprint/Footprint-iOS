//
//  LineGraphView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/24.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

//  마이페이지 - 월별 기록 횟수에 들어갈 그래프

import UIKit

import SnapKit
import Then

class LineGraphView: BaseView {
    var graphLayer = CAShapeLayer()
    var path = UIBezierPath()
    var pointImageSize: CGFloat = 12
    
    var pointValues: [CGFloat] = .init()
    var pointValueLocation: [CGRect] = .init()
    
    init(values: [CGFloat]) {
        self.pointValues = values
        super.init(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let xOffset: CGFloat = self.frame.width / (CGFloat(pointValues.count) - 1)
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x: currentX, y: getHeight(point: 0))
        
        self.path.move(to: startPosition)
        
        for i in 0..<pointValues.count {
            if i == 0 {
                currentX = 0
            } else {
                currentX += xOffset
            }
            
            let newPosition = CGPoint(x: currentX,
                                      y: getHeight(point: i))
            
            pointValueLocation.append(CGRect(x: currentX - pointImageSize / 2, y: getHeight(point: i) - pointImageSize / 2, width: pointImageSize, height: pointImageSize))
            
            self.path.addLine(to: newPosition)
        }
        
        graphLayer.fillColor = nil
        graphLayer.strokeColor = FootprintIOSAsset.Colors.blueM.color.cgColor
        graphLayer.lineWidth = 5
        graphLayer.path = path.cgPath
        graphLayer.lineCap = .round
        
        self.layer.addSublayer(graphLayer)
        
        setGraphPointView()
    }
    
    func setGraphPointView() {
        for i in 0..<pointValues.count {
            let graphView = UIView(frame: pointValueLocation[i])
            let graphPointImage = UIImageView().then {
                $0.image = FootprintIOSAsset.Images.iconGraphPointBlue.image
            }
            
            if(i == pointValues.count - 1) {
                graphPointImage.image = FootprintIOSAsset.Images.iconGraphPointYellow.image
            }

            graphView.addSubview(graphPointImage)
            self.addSubview(graphView)

            graphPointImage.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}

extension LineGraphView {
    func getHeight(point: Int) -> CGFloat {
        let height = self.frame.height - (self.pointValues[point] / 50) * 125
        return height
    }
}
