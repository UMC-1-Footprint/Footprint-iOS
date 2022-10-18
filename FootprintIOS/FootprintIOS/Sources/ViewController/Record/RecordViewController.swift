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
    let distanceTagView: TagView = .init(type: .gray, title: "거리")
    let distanceLabel: UILabel = .init()
    let calorieTagView: TagView = .init(type: .gray, title: "칼로리")
    let calorieLabel: UILabel = .init()
    let paceTagView: TagView = .init(type: .gray, title: "페이스")
    let paceLabel: UILabel = .init()
    let toggleButton: UIButton = .init()
    let divider1: UIView = .init()
    let divider2: UIView = .init()
    let progressView: UIView = .init()
    let progressBarView: UIView = .init()
    let stopButton: RecordButton = .init(type: .stop)
    let stopTagView: TagView = .init(type: .translucent, title: "일시정지")
    let footprintButton: RecordButton = .init(type: .footprint)
    let footprintTagView: TagView = .init(type: .translucent, title: "발자국 남기기")
    let saveButton: RecordButton = .init(type: .save)
    let saveTagView: TagView = .init(type: .translucent, title: "산책 저장")
    
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
        
        distanceLabel.attributedText = NSMutableAttributedString()
            .bold(string: "21 ", fontSize: 18)
            .regular(string: "km", fontSize: 14)
        distanceLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        calorieLabel.attributedText = NSMutableAttributedString()
            .bold(string: "120 ", fontSize: 18)
            .regular(string: "kcal", fontSize: 14)
        calorieLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        paceLabel.attributedText = NSMutableAttributedString()
            .bold(string: "100 ", fontSize: 18)
            .regular(string: "걸음/분", fontSize: 14)
        calorieLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
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
        
        contentView.addSubviews([mapView, topView, stopButton, stopTagView, footprintButton, footprintTagView, saveButton, saveTagView])
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
        
        footprintButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
            $0.width.height.equalTo(70)
        }
        
        footprintTagView.snp.makeConstraints {
            $0.top.equalTo(footprintButton.snp.bottom).offset(11)
            $0.centerX.equalTo(footprintButton)
        }
        
        stopButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(38)
            $0.centerY.equalTo(footprintButton)
            $0.width.height.equalTo(64)
        }
        
        stopTagView.snp.makeConstraints {
            $0.top.equalTo(stopButton.snp.bottom).offset(12)
            $0.centerX.equalTo(stopButton)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(38)
            $0.centerY.equalTo(footprintButton)
            $0.width.height.equalTo(64)
        }
        
        saveTagView.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(11)
            $0.centerX.equalTo(saveButton)
        }
    }
}
