//
//  DateIndicatingView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.

//  그래프 밑의 일, 월, 화, 수, 목, 금, 토 | 3월, 4월 . . .이번달 보여주는 뷰

import UIKit

import SnapKit

class DateIndicatingView: BaseView {
    lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    let dateList: [String]
    let beThick: Bool
    
    init(dateList: [String], beThick: Bool) {
        self.dateList = dateList
        self.beThick = beThick
        
        super.init(frame: .zero)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        for (index, date) in dateList.enumerated() {
            let label = PercentageLabel("\(date)")
            label.font = .systemFont(ofSize: 12, weight: .light)
            if index == dateList.count - 1 && beThick {
                label.font = .systemFont(ofSize: 12, weight: .bold)
            }
            stackView.addArrangedSubview(label)
        }

        addSubview(stackView)
    }
}
