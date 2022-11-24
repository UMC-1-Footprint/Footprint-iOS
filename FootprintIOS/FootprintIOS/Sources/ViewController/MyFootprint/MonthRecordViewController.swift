//
//  MonthRecordViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit

class MonthRecordViewController: BaseViewController {
    let percentageView = AttainmentPercentageView(endPoint: 50, increasementPoint: 10, setPercentage: false)
    let lineView = PercentageLineView()
    lazy var daysList = setMonth()
    lazy var dateView = DateIndicatingView(dateList: daysList, beThick: true)
    let backgroundView = UIView()
    let lineGraphView = LineGraphView(values: [10,50,10,50,10,50,10])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
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
    }
    
    override func setupHierarchy() {
        backgroundView.addSubviews([percentageView, lineView])
        view.addSubviews([backgroundView, lineGraphView, dateView])
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
