//
//  UnderLineView.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/11/07.
//  Copyright © 2022 Footprint-iOS. All rights reserved.

//  마이페이지 - 산책 목표 / 그래프 부분 구분해주는 라인 뷰

import UIKit

import SnapKit

class UnderLineView: BaseView {
    let view: UIView = .init()
    
    override func setupProperty() {
        view.backgroundColor = FootprintIOSAsset.Colors.white4.color
    }
    
    override func setupLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        addSubview(view)
    }
}
