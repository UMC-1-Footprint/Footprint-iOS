//
//  AttainmentPercentageView.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/11/18.
//  Copyright © 2022 Footprint-iOS. All rights reserved.

//  마이페이지 - 그래프: 그래프 왼쪽에 있는 숫자를 나타내는 뷰 

import UIKit

import SnapKit
import Then

class AttainmentPercentageView: BaseView {
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    let endPoint: Int
    let increasementPoint: Int
    
    init(endPoint: Int, increasementPoint: Int) {
        self.endPoint = endPoint
        self.increasementPoint = increasementPoint
        
        super.init(frame: .zero)
    }
    
    override func setupLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        for i in stride(from: endPoint, to: -increasementPoint, by: -increasementPoint) {
            let label = PercentageLable("\(i)")
            stackView.addArrangedSubview(label)
        }
        let label = PercentageLable("(%)")
        stackView.addArrangedSubview(label)

        addSubview(stackView)
    }
}

class PercentageLable: UILabel {
    init(_ labelText: String) {
        super.init(frame: .zero)
        self.text = labelText
        setupProperty()
    }
    
    private func setupProperty() {
        font = .systemFont(ofSize: 10, weight: .light)
        textColor = FootprintIOSAsset.Colors.blackL.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
