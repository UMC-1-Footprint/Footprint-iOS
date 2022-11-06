//
//  TabBarController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewControllers = lazyViewControllers
//
//        let footprintNavigationViewController = UINavigationController(rootViewController: FootprintMapViewController())
//        let footprintTabBarItem = UITabBarItem(title: "홈", image: nil, selectedImage: nil)
//
//        let calendarNavigationViewController = UINavigationController(rootViewController: CalendarViewController())
//        let calendarTabBarItem = UITabBarItem(title: "캘린더", image: nil, selectedImage: nil)
//
//        let recommendNavigationViewController = UINavigationController(rootViewController: RecommendViewController())
//        let recommendTabBarItem = UITabBarItem(title: "코스추천", image: nil, selectedImage: nil)
//
//        let myPageNavigationViewController = UINavigationController(rootViewController: MyPageViewController())
//        let myPageTabBarItem = UITabBarItem(title: "마이 페이지", image: nil, selectedImage: nil)
//
//        footprintNavigationViewController.tabBarItem = footprintTabBarItem
//        calendarNavigationViewController.tabBarItem = calendarTabBarItem
//        recommendNavigationViewController.tabBarItem = recommendTabBarItem
//        myPageNavigationViewController.tabBarItem = myPageTabBarItem
//
//        viewControllers = [footprintNavigationViewController, calendarNavigationViewController, recommendNavigationViewController, myPageNavigationViewController]
        
//        selectedIndex = 0
    }
}
