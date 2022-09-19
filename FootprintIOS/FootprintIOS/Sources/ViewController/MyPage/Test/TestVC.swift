//
//  TestVC.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/09/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit
import SnapKit
import Then

class TestVC: NavigationBarViewController {
    
    let label = UILabel().then {
        $0.text = "안녕하세요"
    }
    
    let apiManager = TestManager(apiService: TestAPIManager(), environment: .test)
    
    func getTestAPI() {
        apiManager.getTestAPI()
            .bind { testModel in
                print("여기에요 여기!")
                print(testModel)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTestAPI()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        setNavigationBarTitleText("api 연습 페이지")
        setNavigationBarBackgroundColor(.white)
        setNavigationBarBackButtonImage(.backButtonIcon)
        setNavigationBarTitleFont(.boldSystemFont(ofSize: 16))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(label)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
