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
    
    func bind(reactor: Reactor) {
        
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
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
        }
        let layoutGroup: NSCollectionLayoutGroup = .vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: layoutItems)
        let layoutSection: NSCollectionLayoutSection = .init(group: layoutGroup)
        return layoutSection
    }
}
