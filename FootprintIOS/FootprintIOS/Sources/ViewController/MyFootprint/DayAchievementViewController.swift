//
//  DayAchievementViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class DayAchievementViewController: BaseViewController {
    let percentageView = AttainmentPercentageView(endPoint: 100, increasementPoint: 20)
    let lineView = PercentageLineView()
    let backgroundView = UIView()
    let percentages = [60,70,80,80,90,50,60]
    lazy var barGraphStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraphView(percentages)
    }
    
    override func setupLayout() {
        percentageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(135)
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(289)
            $0.height.equalTo(125)
            $0.leading.equalTo(percentageView.snp.trailing).offset(8)
            $0.top.equalTo(percentageView.snp.top).offset(5)
        }
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(320)
            $0.height.equalTo(140)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }
        
        barGraphStackView.snp.makeConstraints {
            $0.width.equalTo(244)
            $0.height.equalTo(125)
            $0.bottom.equalTo(lineView.snp.bottom)
            $0.centerX.equalTo(lineView)
        }
    }
    
    override func setupHierarchy() {
        backgroundView.addSubviews([percentageView, lineView])
        view.addSubviews([backgroundView, barGraphStackView])
    }
    
    func setupGraphView(_ percentages: [Int]) {
        for i in 0...6 {
            let graph = BarGraphView(percentage: percentages[i])
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            
            let colors: [CGColor] = [
                FootprintIOSAsset.Colors.blueM.color.cgColor,
               UIColor.white.cgColor
            ]
            gradientLayer.colors = colors
            gradientLayer.locations = [0.01, 0.15]

            graph.mainGraphView.layer.addSublayer(gradientLayer)
            
            barGraphStackView.addArrangedSubview(graph)
        }
    }
}
