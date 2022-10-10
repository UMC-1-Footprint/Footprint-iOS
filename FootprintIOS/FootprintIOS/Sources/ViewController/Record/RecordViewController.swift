//
//  RecordViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/10/08.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import NMapsMap

class RecordViewController: NavigationBarViewController {
    
    // MARK: - UI Components
    
    let mapView: NMFMapView = .init()
    let topView: UIView = .init()
    let timeLabel: UILabel = .init()
    let distanceTagView: TagView = .init(title: "거리")
    let distanceLabel: UILabel = .init()
    let calorieTagView: TagView = .init(title: "칼로리")
    let calorieLabel: UILabel = .init()
    let paceTagView: TagView = .init(title: "페이스")
    let paceLabel: UILabel = .init()
    let toggleButton: UIButton = .init()
    let divider1: UIView = .init()
    let divider2: UIView = .init()
    let progressView: UIView = .init()
    let progressBarView: UIView = .init()
    
    // MARK: - Setup Methods
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("실시간 기록")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        topView.backgroundColor = .white
        
        timeLabel.text = "17:21"
        timeLabel.font = .systemFont(ofSize: 28, weight: .bold)
        timeLabel.textColor = .black
        
        distanceLabel.text = "21 km"
        distanceLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        distanceLabel.font = .systemFont(ofSize: 14)
        
        calorieLabel.text = "120 kcal"
        calorieLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        calorieLabel.font = .systemFont(ofSize: 14)
        
        paceLabel.text = "100 걸음/분"
        calorieLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        paceLabel.font = .systemFont(ofSize: 14)
        
        divider1.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        divider2.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        toggleButton.setImage(.init(systemName: "chevron.down"), for: .normal)
        toggleButton.tintColor = .black
        
        progressView.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        progressBarView.backgroundColor = FootprintIOSAsset.Colors.blueM.color
        progressBarView.cornerRound(radius: 4, direct: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([mapView, topView])
        topView.addSubviews([timeLabel, distanceTagView, distanceLabel, divider1, calorieTagView, calorieLabel, divider2, paceTagView, paceLabel, toggleButton, progressView])
        progressView.addSubviews([progressBarView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        distanceTagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(timeLabel.snp.trailing).offset(30)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(distanceTagView.snp.bottom).offset(4)
            $0.leading.equalTo(distanceTagView)
        }
        
        divider1.snp.makeConstraints {
            $0.leading.equalTo(distanceTagView.snp.trailing).offset(20)
            $0.centerY.equalTo(timeLabel)
            $0.width.equalTo(1)
            $0.height.equalTo(16)
        }
        
        calorieTagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(divider1.snp.trailing).offset(10)
        }
        
        calorieLabel.snp.makeConstraints {
            $0.top.equalTo(calorieTagView.snp.bottom).offset(4)
            $0.leading.equalTo(calorieTagView)
        }
        
        divider2.snp.makeConstraints {
            $0.leading.equalTo(calorieTagView.snp.trailing).offset(20)
            $0.centerY.equalTo(timeLabel)
            $0.width.equalTo(1)
            $0.height.equalTo(16)
        }
        
        paceTagView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalTo(divider2.snp.trailing).offset(10)
        }
        
        paceLabel.snp.makeConstraints {
            $0.top.equalTo(paceTagView.snp.bottom).offset(4)
            $0.leading.equalTo(paceTagView)
        }
        
        toggleButton.snp.makeConstraints {
            $0.centerY.equalTo(timeLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        progressBarView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.3)
        }
    }
}
