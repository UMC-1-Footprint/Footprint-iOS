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
        
        let walkService: WalkServiceType = WalkService()
        let walkRecordService: WalkRecordServiceType = WalkRecordService()
        let infoService: InfoServiceType = InfoService()
        
        let tabBarViewController = TabBarViewController()
        let footprintRootViewController = makeFootprintRootScreen(walkService: walkService)
        let calendarViewController = makeCalendarScreen(infoService: infoService)
        let recommendViewController = makeRecommendScreen()
        let myPageViewController = makeMyPageScreen(walkRecordService: walkRecordService)
        
        tabBarViewController.viewControllers = [
            footprintRootViewController.navigationWrap(),
            calendarViewController.navigationWrap(),
            recommendViewController.navigationWrap(),
            myPageViewController.navigationWrap()
        ]

        return tabBarViewController
    }
    
    static func makeFootprintRootScreen(walkService: WalkServiceType) -> FootprintRootViewController {
        let pushFootprintWriteScreen: () -> FootprintWriteViewController = {
            let reactor = FootprintWriteReactor(state: .init())
            let controller = FootprintWriteViewController(reactor: reactor)
            return controller
        }
        
        let pushFootprintMapScreen: () -> FootprintMapViewController = {
            let reactor = FootprintMapReactor(state: .init())
            let controller = FootprintMapViewController(reactor: reactor,
                                                        pushFootprintWriteScreen: pushFootprintWriteScreen)
            return controller
        }
        
        let pushRecordSearchScreen: (Int) -> RecordSearchViewController = { (id) in
            let reactor: RecordSearchReactor = .init(id: id, walkService: walkService)
            return .init(reactor: reactor)
        }

        let reactor = FootprintRootReactor(state: .init())
        let controller = FootprintRootViewController(reactor: reactor,
                                                     pushFootprintMapScreen: pushFootprintMapScreen,
                                                     pushRecordSearchScreen: pushRecordSearchScreen)
        
        controller.title = "홈"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeCalendarScreen(infoService: InfoServiceType) -> CalendarViewController {
        let pushGoalScreen: (UserInfoRequestModel) -> GoalViewController = { (userInfo) in
            let reactor = GoalReactor.init(service: infoService, userInfo: userInfo)
            let controller = GoalViewController(reactor: reactor)
            
            return controller
        }
    
        let pushInfoScreen: () -> InfoViewController = {
            let reactor = InfoReactor.init(service: infoService)
            let controller = InfoViewController(reactor: reactor,
                                                pushGoalScreen: pushGoalScreen)
            
            return controller
        }
        
        let pushGoalEditNextMonthScreen: () -> GoalEditNextMonthViewController = {
            let reactor = GoalEditNextMonthReactor.init(service: infoService)
            let controller = GoalEditNextMonthViewController(reactor: reactor)
            
            return controller
        }
        
        let pushGoalEditThisMonthScreen: () -> GoalEditThisMonthViewController = {
            let reactor = GoalEditThisMonthReactor.init(service: infoService)
            let controller = GoalEditThisMonthViewController(reactor: reactor, pushGoalEditNextMonthScreen: pushGoalEditNextMonthScreen)
            
            return controller
        }
        
        let reactor = CalendarReactor(state: .init())
        let controller = CalendarViewController(reactor: reactor,
                                                pushInfoScreen: pushInfoScreen, pushGoalEditThisMonthScreen: pushGoalEditThisMonthScreen)
        
        controller.title = "캘린더"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeRecordCalendarScreen(walkService: WalkServiceType) -> RecordCalendarViewController {
        let pushRecordSearchScreen: (Int) -> RecordSearchViewController = { (id) in
            let reactor: RecordSearchReactor = .init(id: id, walkService: walkService)
            return .init(reactor: reactor)
        }
        
        let reactor: RecordCalendarReactor = .init()
        let controller: RecordCalendarViewController = .init(reactor: reactor, pushRecordSearchScreen: pushRecordSearchScreen)
        
        controller.title = "산책기록"
        return controller
    }
    
    static func makeRecommendScreen() -> RecommendViewController {
        let controller = RecommendViewController()
        
        controller.title = "코스추천"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
    
    static func makeMyPageScreen(walkRecordService: WalkRecordServiceType) -> MyPageViewController {
        var pushMyFootprintScreen: () -> MyFootprintViewController
        pushMyFootprintScreen = {
            let controller = MyFootprintViewController()
            
            return controller
        }
        
        var pushWalkRecordScreen: () -> WalkRecordViewController
        pushWalkRecordScreen = {
            let reactor = WalkRecordReactor(service: walkRecordService)
            let controller = WalkRecordViewController(reactor: reactor)
            return controller
        }
        
        let controller = MyPageViewController(pushMyFootprintScreen: pushMyFootprintScreen, pushWalkRecordScreen: pushWalkRecordScreen)
        
        controller.title = "마이 페이지"
        controller.tabBarItem.image = nil
        controller.tabBarItem.selectedImage = nil
        return controller
    }
}
