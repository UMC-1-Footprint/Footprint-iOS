//
//  WalkRecordCalendarHeader.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/12/26.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import Then

class WalkRecordCalendarHeader: BaseCollectionReusableView {
    let prevMonthButton = UIButton().then {
        $0.setImage(UIImage(named: FootprintIOSAsset.Images.iconSwipe.name), for: .normal)
    }

    let nextMonthButton = UIButton().then {
        $0.setImage(UIImage(named: FootprintIOSAsset.Images.iconSwipe.name), for: .normal)
        $0.transform = $0.transform.rotated(by: .pi)
    }
    
    let monthLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    let monthControlStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    let dateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    let dateList: [String] = ["일","월","화","수","목","금","토"]
    
    let topLineView = UIView()
    let bottomLineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        for date in dateList {
            let dateLabel = UILabel().then {
                $0.text = date
                $0.font = .systemFont(ofSize: 12)
            }
            
            dateStackView.addArrangedSubview(dateLabel)
        }
        
        [topLineView, bottomLineView].forEach {
            $0.backgroundColor = FootprintIOSAsset.Colors.whiteM.color
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        monthControlStackView.addArrangedSubviews(prevMonthButton, monthLabel, nextMonthButton)
        addSubviews([monthControlStackView, topLineView, dateStackView, bottomLineView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [prevMonthButton, nextMonthButton].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(12)
                $0.width.equalTo(8)
            }
        }
        
        monthControlStackView.snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(12)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        dateStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(28)
            $0.bottom.equalToSuperview().inset(1)
        }
        
        topLineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(dateStackView.snp.top)
        }
        
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

