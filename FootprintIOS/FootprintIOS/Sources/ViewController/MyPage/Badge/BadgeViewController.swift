//
//  MyPageViewController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/23.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class BadgeViewController: NavigationBarViewController {
    
    let badgeView = BadgeView()
        
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("달성 뱃지")
        setNavigationBarBackgroundColor(.white)
        setNavigationBarBackButtonImage(.backButtonIcon)
        setNavigationBarTitleFont(.boldSystemFont(ofSize: 16))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(badgeView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        badgeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        badgeView.badgeListCollectionView.delegate = self
        badgeView.badgeListCollectionView.dataSource = self
    }
}

// MARK: - extension
extension BadgeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width * (100/375)
        let cellHeight = cellWidth * (120/100)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension BadgeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BadgeModel.dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeListCollectionViewCell.identifier, for: indexPath) as? BadgeListCollectionViewCell else { return UICollectionViewCell() }
        cell.setBadgeListCell(badge: BadgeModel.dummyData[indexPath.row])
        return cell
    }
    
}

