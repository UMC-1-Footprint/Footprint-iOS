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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func setupHierarchy() {
        view.addSubviews([percentageView, lineView])
    }
}
