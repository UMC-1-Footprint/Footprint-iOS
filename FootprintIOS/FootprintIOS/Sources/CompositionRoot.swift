//
//  CompositionRoot.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/11/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import UIKit

struct AppDependency {
    let window: UIWindow
    let configureSDKs: () -> Void
    let configureAppearance: () -> Void
}

class CompositionRoot {
    static func resolve(windowScene: UIWindowScene) -> AppDependency {
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        window.rootViewController = makeTabBarScreen()
        
        return AppDependency(window: window,
                             configureSDKs: self.configureSDKs,
                             configureAppearance: self.configureAppearance)
    }
    
    static func configureSDKs() { }
    
    static func configureAppearance() { }
}

extension CompositionRoot {
    static func makeTabBarScreen() -> TabBarViewController {
        
        let tabBarViewController = TabBarViewController()
        
        let footprintViewController = makeFootprintScreen()
        
        let calendarViewController = makeCalendarScreen()
        
        let recommendViewController = makeRecommendScreen()
        
        let myPageViewController = makeMyPageScreen()
        
        tabBarViewController.viewControllers = [
            footprintViewController.navigationWrap(),
            calendarViewController.navigationWrap(),
            recommendViewController.navigationWrap(),
            myPageViewController.navigationWrap()
        ]

        return tabBarViewController
    }
    
    static func makeFootprintScreen() -> FootprintMapViewController {
        let controller = FootprintMapViewController()
        
        controller.title = "홈"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeCalendarScreen() -> CalendarViewController {
        let controller = CalendarViewController()
        
        controller.title = "캘린더"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeRecommendScreen() -> RecommendViewController {
        let controller = RecommendViewController()
        
        controller.title = "코스추천"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeMyPageScreen() -> MyPageViewController {
        let controller = MyPageViewController()
        
        controller.title = "마이 페이지"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
}
