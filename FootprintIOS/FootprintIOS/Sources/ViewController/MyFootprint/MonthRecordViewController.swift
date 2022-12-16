//
//  MonthRecordViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

//  마이페이지 - 월별 기록 횟수

import UIKit

import SnapKit

class MonthRecordViewController: BaseViewController {
    let percentageView = AttainmentPercentageView(endPoint: 50, increasementPoint: 10, setPercentage: false)
    let lineView = PercentageLineView()
    lazy var daysList = setMonth()
    lazy var dateView = DateIndicatingView(dateList: daysList, beThick: true)
    let backgroundView = UIView()
    let lineGraphView = LineGraphView(values: [0,20,10,50,30,50,10])
    let summaryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setSummaryLabel(changeText: "56%")
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
        
        dateView.snp.makeConstraints {
            $0.width.equalTo(260)
            $0.top.equalTo(backgroundView.snp.bottom).offset(17)
            $0.leading.equalTo(percentageView.snp.trailing).offset(30)
        }
        
        lineGraphView.snp.makeConstraints {
            $0.width.equalTo(244)
            $0.height.equalTo(125)
            $0.bottom.equalTo(lineView.snp.bottom)
            $0.centerX.equalTo(lineView)
        }
        
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        backgroundView.addSubviews([percentageView, lineView])
        view.addSubviews([backgroundView, lineGraphView, dateView, summaryLabel])
    }
    
    private func setSummaryLabel(changeText: String) {
        summaryLabel.textColor = FootprintIOSAsset.Colors.blackM.color
        summaryLabel.text = "이번달엔 \(changeText) 기록했어요"
        summaryLabel.font = .systemFont(ofSize: 14)
        
        guard let text = summaryLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        let font = UIFont.boldSystemFont(ofSize: 14)

        attributeString.addAttribute(.foregroundColor, value: FootprintIOSAsset.Colors.yellowM.color, range: (text as NSString).range(of: changeText))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: changeText))
                
        summaryLabel.attributedText = attributeString
    }
    
    func setMonth() -> [String] {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        var monthList: [String] = .init()
        
        for i in 0...5 {
            let newMonth = month - (6-i)
            if newMonth <= 0 {
                monthList.append("\(newMonth + 12)월")
            } else {
                monthList.append("\(newMonth)월")
            }
        }
        monthList.append("이번달")
        return monthList
    }
}
