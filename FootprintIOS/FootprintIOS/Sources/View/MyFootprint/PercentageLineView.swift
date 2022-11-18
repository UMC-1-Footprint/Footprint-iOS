//
//  PercentageLineView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.

//  마이페이지 - 그래프: 뒷 배경에 있는 라인으로 그려질 뷰 

import UIKit

import SnapKit
import Then

class PercentageLineView: BaseView {
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    
    override func setupLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        for _ in 0...5 {
            let view = UIView().then {
                $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
            }
            
            view.snp.makeConstraints {
                $0.width.equalTo(289)
                $0.height.equalTo(0.5)
            }
            
            stackView.addArrangedSubview(view)
        }

        addSubview(stackView)
    }
}
