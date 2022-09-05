//
//  NoticeViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/09/05.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import RxDataSources
import ReactorKit

class NoticeViewController: NavigationBarViewController, View {
    typealias Reactor = NoticeReactor
    typealias DataSource = RxTableViewSectionedReloadDataSource<NoticeSectionModel>
    
    // MARK: - UI Components
    
    let tableView: UITableView = .init()
    
    // MARK: - Properties
    
    private lazy var dataSource = DataSource { _, tableView, indexPath, item -> UITableViewCell in
        switch item {
        case let .notice(reactor):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoticeTableViewCell.self)) as? NoticeTableViewCell else { return .init() }
            
            cell.reactor = reactor
            return cell
        }
    }
    
    // MARK: - Initializer
    
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
        
        setNavigationBarTitleText("공지사항")
        setNavigationBarBackButtonHidden(false)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: String(describing: NoticeTableViewCell.self))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubviews([tableView])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        reactor.state
            .map(\.sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        rx.viewWillAppear
            .map { _ in .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension NoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}
