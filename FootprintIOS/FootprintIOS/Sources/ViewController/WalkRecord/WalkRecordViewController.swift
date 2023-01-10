//
//  WalkRecordViewController.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/12/19.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxDataSources
import ReactorKit

class WalkRecordViewController: BaseViewController, View {
    typealias Reactor = WalkRecordReactor
    typealias WalkRecordDataSource = RxCollectionViewSectionedReloadDataSource<WalkRecordSectionModel>
    
    private lazy var dataSource = WalkRecordDataSource { [weak self] _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .calendar(day):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WalkRecordCollectionViewCell.self), for: indexPath) as? WalkRecordCollectionViewCell else { return .init() }
            cell.setData(day: day)
            
            return cell
        case let .walkSummary(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecordCollectionViewCell.self), for: indexPath) as? RecordCollectionViewCell else { return .init() }
            cell.reactor = reactor
            return cell
        }
    } configureSupplementaryView: { [self] (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
        switch dataSource[indexPath.section].model {
        case .calendar:
           guard let reactor = reactor,
                 let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WalkRecordCalendarHeader.self), for: indexPath) as? WalkRecordCalendarHeader else { return .init() }
            
            header.prevMonthButton.rx.tap
                .map { _ in .prevMonth }
                .bind(to: reactor.action)
                .disposed(by: header.disposeBag)
            
            header.nextMonthButton.rx.tap
                .map { _ in .nextMonth }
                .bind(to: reactor.action)
                .disposed(by: header.disposeBag)
        
            reactor.state
                .map(\.monthTitle)
                .bind(to: header.monthLabel.rx.text)
                .disposed(by: header.disposeBag)
            
            return header
        case .walkSummary:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WalkRecordSummaryHeader.self), for: indexPath) as? WalkRecordSummaryHeader else { return .init() }
            
            return header
        }
    }
    
    let walkRecordTitleLabel = UILabel().then {
        $0.text = "산책기록"
        $0.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 800))
        $0.textColor = FootprintIOSAsset.Colors.blackD.color
    }
    let searchButton = UIButton().then { //MARK: - 아이콘 이미지 수정하기
        $0.setImage(UIImage(named: FootprintIOSAsset.Images.settingsIcon.name), for: .normal)
    }
    let navigationView: UIView = .init()
    let underlineView = UIView().then {
        $0.backgroundColor = FootprintIOSAsset.Colors.whiteD.color
    }
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 0
    }
    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        walkRecordTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(underlineView).offset(1)
            $0.leading.trailing.equalTo(self.view)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        navigationView.addSubviews([walkRecordTitleLabel, searchButton])
        view.addSubviews([navigationView, underlineView, collectionView])
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        collectionView.register(WalkRecordCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: WalkRecordCollectionViewCell.self))
        collectionView.register(WalkRecordCalendarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WalkRecordCalendarHeader.self))
        collectionView.register(WalkRecordSummaryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: WalkRecordSummaryHeader.self))
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecordCollectionViewCell.self))
    }
    
    func bind(reactor: WalkRecordReactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map(\.walkRecordSection)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .filter { $0[0] == 0 }
            .bind { this in
                print("cell 클릭됨")
            }
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension WalkRecordViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch dataSource[indexPath.section].model {
        case .calendar:
            let width = self.view.frame.width

            let cellWidth = ( width - 24.0 ) / 7.0
            let cellHeight = 60.0
            
            return CGSize(width: cellWidth, height: cellHeight)
        case .walkSummary:
            let width = self.view.frame.width

            let cellWidth = width - 24.0
            let cellHeight = 104.0
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch dataSource[section].model {
        case .calendar:
            return CGSize(width: self.view.frame.width, height: 80.0)
        case .walkSummary:
            return CGSize(width: self.view.frame.width, height: 40.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch dataSource[section].model {
        case .calendar:
            return 0
        case .walkSummary:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInset = UIEdgeInsets()
        
        switch dataSource[section].model {
        case .calendar:
            edgeInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        case .walkSummary:
            edgeInset = UIEdgeInsets(top: 16, left: 0, bottom: 12, right: 0)
        }

        return edgeInset;
    }
}
