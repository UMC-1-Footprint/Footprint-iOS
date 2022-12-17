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
    let setPercentage: Bool
    
    init(endPoint: Int, increasementPoint: Int, setPercentage: Bool) {
        self.endPoint = endPoint
        self.increasementPoint = increasementPoint
        self.setPercentage = setPercentage
        
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
        
        for i in stride(from: endPoint, to: -increasementPoint, by: -increasementPoint) {
            let label = PercentageLabel("\(i)")
            stackView.addArrangedSubview(label)
        }
        let label = setPercentage ? PercentageLabel("(%)") : PercentageLabel("(회)")
        stackView.addArrangedSubview(label)

        addSubview(stackView)
    }
}

class PercentageLabel: UILabel {
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
