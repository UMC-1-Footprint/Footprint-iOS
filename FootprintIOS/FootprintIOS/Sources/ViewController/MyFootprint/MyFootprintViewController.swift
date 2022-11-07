//
//  MyFootprintViewController.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift

class MyFootprintViewController: BaseViewController {
    // MARK: - UI Components
    
    // MARK: - topInfo
    let myFootprintLabel: UILabel = .init()
    let settingButton: UIButton = .init()
    let navigationView: UIView = .init()
    let underlineView: UIView = .init()
    let myFootprintScrollView: UIScrollView = .init()
    let topInfoView: UIView = .init()
    let userBagdeImageView: UIImageView = .init()
    let userNameStackView: UIStackView = .init()
    let userNameLabel: UILabel = .init()
    let userRepresentNicknameLabel: UILabel = .init()
    let moreButton: UIButton = .init()
    
    // MARK: - middleSummary
    lazy var todayChartView =  AttainmentRateChartView(keyColor: FootprintIOSAsset.Colors.blueM.color, petcentageAngle: 90)
    lazy var monthChartView = AttainmentRateChartView(keyColor: FootprintIOSAsset.Colors.yellowM.color, petcentageAngle: 56)
    let monthFootprintView: UIView = .init()
    let monthFootprintCountLabel: UILabel = .init()
    
    let todayChartLabel: UILabel = .init()
    let monthChartLabel: UILabel = .init()
    let monthFootprintLabel: UILabel = .init()
    
    let todayChartStackView: UIStackView = .init()
    let monthChartStackView: UIStackView = .init()
    let monthFootprintCountStackView: UIStackView = .init()
    let middleSummaryStackView: UIStackView = .init()
    
    
    
    let testView: UIView = .init()
 
    override func setupProperty() {
        super.setupProperty()
        
        myFootprintLabel.text = "마이페이지"
        myFootprintLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        myFootprintLabel.textColor = FootprintIOSAsset.Colors.blackD.color
        
        settingButton.setImage(UIImage(named: FootprintIOSAsset.Images.settingsIcon.name), for: .normal)
        
        underlineView.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
        
        // MARK: - topInfo
        userBagdeImageView.image = FootprintIOSAsset.Images.myFootbadge.image
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 8
        userNameLabel.attributedText = NSMutableAttributedString()
            .bold(string: "닉네임 ", fontSize: 16)
            .regular(string: "님", fontSize: 16)

        userRepresentNicknameLabel.text = "발자국 스타터"
        userRepresentNicknameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        moreButton.setImage(FootprintIOSAsset.Images.backIcon.image, for: .normal)
        
        // MARK: - middleSummary
        todayChartLabel.text = "오늘 달성률"
        monthChartLabel.text = "이번 달 달성률"
        monthFootprintLabel.text = "이번 달 산책횟수"
        monthFootprintCountLabel.text = "20회"
        
        monthFootprintCountLabel.font = .systemFont(ofSize: 28, weight: UIFont.Weight(rawValue: 700))
        monthFootprintCountLabel.textColor = FootprintIOSAsset.Colors.yellowM.color
        
        [todayChartLabel, monthChartLabel, monthFootprintLabel].forEach {
            $0.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 300))
            $0.textColor = FootprintIOSAsset.Colors.blackL.color
        }
        
        middleSummaryStackView.axis = .horizontal
        middleSummaryStackView.distribution = .equalSpacing
        
        [todayChartStackView, monthChartStackView, monthFootprintCountStackView].forEach {
            $0.axis = .vertical
            $0.alignment = .center
        }
        
        // MARK: - middleSummary
        testView.backgroundColor = .blue
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        myFootprintLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        myFootprintScrollView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        topInfoView.snp.makeConstraints {
            $0.left.right.equalTo(self.view)
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        }
        
        userBagdeImageView.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }
        
        userNameStackView.snp.makeConstraints {
            $0.leading.equalTo(userBagdeImageView.snp.trailing).offset(9)
            $0.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(topInfoView.snp.trailing).inset(16)
        }
        
        todayChartView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        
        monthChartView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        
        monthFootprintView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        
        monthFootprintCountLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        middleSummaryStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topInfoView.snp.bottom)
            $0.height.equalTo(130)
            $0.width.equalTo(320)
        }
        
        testView.snp.makeConstraints {
            $0.top.equalTo(middleSummaryStackView.snp.bottom).offset(10)
            $0.width.equalTo(self.view)
            $0.height.equalTo(800)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        navigationView.addSubviews([myFootprintLabel, settingButton])
        
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userRepresentNicknameLabel)
        topInfoView.addSubviews([userBagdeImageView, userNameStackView, moreButton])
        monthFootprintView.addSubview(monthFootprintCountLabel)
        
        [todayChartView, todayChartLabel].forEach {
            todayChartStackView.addArrangedSubview($0)
        }
        
        [monthChartView, monthChartLabel].forEach {
            monthChartStackView.addArrangedSubview($0)
        }
        
        [monthFootprintView, monthFootprintLabel].forEach {
            monthFootprintCountStackView.addArrangedSubview($0)
        }
        
        [todayChartStackView, monthChartStackView, monthFootprintCountStackView].forEach {
            middleSummaryStackView.addArrangedSubview($0)
        }
        
        myFootprintScrollView.addSubviews([topInfoView, middleSummaryStackView, testView])
        view.addSubviews([navigationView, underlineView, myFootprintScrollView])
    }
}
