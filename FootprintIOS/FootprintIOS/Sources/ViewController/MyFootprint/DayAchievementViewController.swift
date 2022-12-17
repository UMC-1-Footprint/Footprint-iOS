//
//  DayAchievementViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

//  마이페이지 - 요일별 달성률 

import UIKit

import SnapKit
import Then

class DayAchievementViewController: BaseViewController {
    let percentageView = AttainmentPercentageView(endPoint: 100, increasementPoint: 20, setPercentage: true)
    let lineView = PercentageLineView()
    let daysList = ["일","월","화","수","목","금","토"]
    lazy var dateView = DateIndicatingView(dateList: daysList, beThick: false)
    let backgroundView = UIView()
    let percentages = [60,70,80,80,90,50,60] // TODO
    lazy var barGraphStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    let summaryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraphView(percentages)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setSummaryLabel(changeText: "수요일")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        percentageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(160)
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
        
        dateView.snp.makeConstraints {
            $0.width.equalTo(244)
            $0.top.equalTo(barGraphStackView.snp.bottom).offset(17)
            $0.leading.equalTo(percentageView.snp.trailing).offset(30)
        }
        
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundView.addSubviews([percentageView, lineView])
        view.addSubviews([backgroundView, barGraphStackView, dateView, summaryLabel])
    }
    
    private func setupGraphView(_ percentages: [Int]) {
        for item in percentages {
            let graph = BarGraphView(percentage: item)
            
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
    
    private func setSummaryLabel(changeText: String) {
        summaryLabel.textColor = FootprintIOSAsset.Colors.blackM.color
        summaryLabel.text = "주로 \(changeText)에 산책을 가장 많이 나가요"
        summaryLabel.font = .systemFont(ofSize: 14)
        
        guard let text = summaryLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        let font = UIFont.boldSystemFont(ofSize: 14)

        attributeString.addAttribute(.foregroundColor, value: FootprintIOSAsset.Colors.yellowM.color, range: (text as NSString).range(of: changeText))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText))
                
        summaryLabel.attributedText = attributeString
    }
}
