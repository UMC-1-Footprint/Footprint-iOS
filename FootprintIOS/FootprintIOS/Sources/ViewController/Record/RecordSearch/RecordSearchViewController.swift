//
//  RecordSearchViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import ReactorKit
import RxDataSources

class RecordSearchViewController: NavigationBarViewController, View {

    // MARK: - Properties
    
    typealias Reactor = RecordSearchReactor
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<RecordSearchSectionModel>
    
    private lazy var dataSource = DataSource { _, collectionView, indexPath, item -> UICollectionViewCell in
        switch item {
        case let .search(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchCollectionViewCell.self), for: indexPath) as? SearchCollectionViewCell else { return .init() }
            cell.reactor = reactor
            return cell
            
        case let .record(reactor):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecordCollectionViewCell.self), for: indexPath) as? RecordCollectionViewCell else { return .init() }
            cell.reactor = reactor
            return cell
        }
    } configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath -> UICollectionReusableView in
        switch dataSource[indexPath.section].model {
        case .record:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: RecordHeaderView.self), for: indexPath) as? RecordHeaderView else { return .init() }
            
            return header
            
        case .search:
            return .init()
        }
    }
    
    // MARK: - UI Components
    
    let searchView: UIView = .init()
    let searchTextField: UITextField = .init()
    let searchImageView: UIImageView = .init()
    let cancleButton: UIButton = .init()
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarHidden(true)
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecordCollectionViewCell.self))
        collectionView.register(RecordHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: RecordHeaderView.self))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        let leftView: UIView = .init(frame: .init(x: 0, y: 0, width: 36, height: 36))
        let imgView: UIImageView = .init(frame: .init(x: 0, y: 0, width: 16, height: 16))
    
        imgView.image = FootprintIOSAsset.Images.iconSearch.image
        imgView.tintColor = FootprintIOSAsset.Colors.blackL.color
        
        leftView.addSubview(imgView)
        
        leftView.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        imgView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        
        contentView.backgroundColor = FootprintIOSAsset.Colors.whiteBG.color
        
        searchView.backgroundColor = .white
        
        searchTextField.backgroundColor = FootprintIOSAsset.Colors.whiteM.color
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        searchTextField.cornerRound(radius: 12)
        
        searchTextField.placeholder = "산책 제목, #태그 검색"
        
        cancleButton.setTitle("취소", for: .normal)
        cancleButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cancleButton.setTitleColor(FootprintIOSAsset.Colors.blackL.color, for: .normal)
        
        collectionView.backgroundColor = FootprintIOSAsset.Colors.whiteBG.color
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([searchView, collectionView])
        searchView.addSubviews([searchTextField, cancleButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.trailing.equalTo(cancleButton.snp.leading).inset(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        cancleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDataSource(dataSource).disposed(by: disposeBag)
        
        reactor.state
            .map(\.sections)
            .withUnretained(self)
            .bind { this, sections in
                this.dataSource.setSections(sections)
                this.collectionView.collectionViewLayout = this.makeCompositionLayout(from: sections)
            }
            .disposed(by: disposeBag)
    }
}

extension RecordSearchViewController {
    func makeCompositionLayout(from sections: [RecordSearchSectionModel]) -> UICollectionViewCompositionalLayout {
        let layout: UICollectionViewCompositionalLayout = .init { [weak self] index,_ in
            switch sections[index].model {
            case let .search(items):
                return self?.makeSearchLayoutSection(from: items)
                
            case let .record(items):
                return self?.makeRecordLayoutSection(from: items)
            }
        }
        
        return layout
    }
    
    func makeSearchLayoutSection(from items: [RecordSearchItem]) -> NSCollectionLayoutSection {
        let layoutItems: [NSCollectionLayoutItem] = items.map { item in
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)))
        }
        let layoutGroup: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: layoutItems)
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        
        return layoutSection
    }
    
    func makeRecordLayoutSection(from items: [RecordSearchItem]) -> NSCollectionLayoutSection {
        let layoutItems: [NSCollectionLayoutItem] = items.map { item in
            let layoutItem: NSCollectionLayoutItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(104)))
            layoutItem.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return layoutItem
        }
        let layoutGroup: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: layoutItems)
        layoutGroup.interItemSpacing = .fixed(12)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
}
