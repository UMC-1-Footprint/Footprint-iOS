//
//  TabBarController.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/08/22.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footprintNavigationViewController = UINavigationController(rootViewController: FootprintViewController())
        let footprintTabBarItem = UITabBarItem(title: "홈", image: nil, selectedImage: nil)
        
        let calendarNavigationViewController = UINavigationController(rootViewController: CalendarViewController())
        let calendarTabBarItem = UITabBarItem(title: "캘린더", image: nil, selectedImage: nil)
        
        let recommendNavigationViewController = UINavigationController(rootViewController: RecommendViewController())
        let recommendTabBarItem = UITabBarItem(title: "코스추천", image: nil, selectedImage: nil)
        
        let myPageNavigationViewController = UINavigationController(rootViewController: MyPageViewController())
        let myPageTabBarItem = UITabBarItem(title: "마이 페이지", image: nil, selectedImage: nil)
        
        footprintNavigationViewController.tabBarItem = footprintTabBarItem
        calendarNavigationViewController.tabBarItem = calendarTabBarItem
        recommendNavigationViewController.tabBarItem = recommendTabBarItem
        myPageNavigationViewController.tabBarItem = myPageTabBarItem
        
        viewControllers = [footprintNavigationViewController, calendarNavigationViewController, recommendNavigationViewController, myPageNavigationViewController]
        
        selectedIndex = 0
    }
}
