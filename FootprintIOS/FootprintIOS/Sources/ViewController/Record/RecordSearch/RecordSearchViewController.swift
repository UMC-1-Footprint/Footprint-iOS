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
    }
    
    // MARK: - UI Components
    
    let searchView: UIView = .init()
    let searchTextField: UITextField = .init()
    let imageView: UIImageView = .init()
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
    
    override func setupProperty() {
        super.setupProperty()
        collectionView.backgroundColor = FootprintIOSAsset.Colors.whiteBG.color
        collectionView.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecordCollectionViewCell.self))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([collectionView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
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
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        return layoutSection
    }
}
