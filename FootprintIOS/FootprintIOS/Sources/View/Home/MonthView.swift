//
//  MonthView.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/10/10.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import ReactorKit

class MonthView: BaseView {
    
    // MARK: - UI Components
    
    let monthLabel = UILabel().then {
        let now = Date()
        $0.text = "\(now.year)년 \(now.month)월"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
    }
    
    lazy var dayStackView = UIStackView().then {
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.axis = .horizontal
    }
    
    let line1View = UIView()
    let line2View = UIView()
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 0
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MonthCollectionViewCell.self))
    }
    
    let timeLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "총 시간 \n", fontSize: 12)
            .bold(string: "135", fontSize: 24)
            .regular(string: " 시간", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let distanceLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "거리 \n", fontSize: 12)
            .bold(string: "2.1", fontSize: 24)
            .regular(string: " km", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let calorieLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
            .regular(string: "칼로리 \n", fontSize: 12)
            .bold(string: "120", fontSize: 24)
            .regular(string: " kcal", fontSize: 12)
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let line3View = UIView()
    let line4View = UIView()
    
    lazy var monthStackView = UIStackView().then {
        $0.addArrangedSubviews(timeLabel, line3View, distanceLabel, line4View, calorieLabel)
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
        $0.axis = .horizontal
    }
    
    private let bottomButton = FootprintButton(type: .startWalk)
    
    // MARK: - Methods
    
    override func setupProperty() {
        super.setupProperty()
        
        for day in ["일", "월", "화", "수", "목", "금", "토"] {
            let dayLabel = UILabel().then {
                $0.text = day
                $0.font = .systemFont(ofSize: 12)
                $0.textColor = FootprintIOSAsset.Colors.blackD.color
            }
            dayStackView.addArrangedSubview(dayLabel)
        }
        
        [line1View, line2View].forEach {
            $0.backgroundColor = FootprintIOSAsset.Colors.whiteM.color
        }
        
        [line3View, line4View].forEach {
            $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubviews([monthLabel, dayStackView, line1View, collectionView,line2View,  monthStackView, bottomButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        monthLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(28)
        }
        
        line1View.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(dayStackView.snp.bottom).offset(10)
            $0.bottom.equalTo(monthStackView.snp.top).offset(-10)
        }
        
        line2View.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        [line3View, line4View].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(1)
                $0.height.equalTo(35)
            }
        }
        
        monthStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
        
        bottomButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
