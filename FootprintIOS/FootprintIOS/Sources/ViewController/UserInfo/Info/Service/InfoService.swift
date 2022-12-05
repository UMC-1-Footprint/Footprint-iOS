//
//  InfoService.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxSwift

enum InfoType {
    case birth
    case walk
    case goalWalk
}

enum InfoEvent {
    case updateInfo(type: InfoType, content: String)
}

protocol InfoServiceProtocol {
    var event: PublishSubject<InfoEvent> { get }
    
    func createInfo()
    func updateBirth(to birth: String) -> Observable<String>
    func updateWalk(to walk: String) -> Observable<String>
    func updateGoalWalk(to goalWalk: String) -> Observable<String>
    func updateUserInfo(userInfo: InfoModel)
    func updateGoalInfo(goalInfo: GoalModel)
}

class InfoService: InfoServiceProtocol {
    
    let event = PublishSubject<InfoEvent>()
    
    private var userInfo: InfoModel?
    private var goalInfo: GoalModel?
    
    func createInfo() {
        // 서버 통신
        print(self.userInfo)
        print(self.goalInfo)
    }
    
    func updateBirth(to birth: String) -> Observable<String> {
        event.onNext(.updateInfo(type: .birth, content: birth))
        return .just(birth)
    }
    
    func updateWalk(to walk: String) -> RxSwift.Observable<String> {
        event.onNext(.updateInfo(type: .walk, content: walk))
        return .just(walk)
    }
    
    func updateGoalWalk(to goalWalk: String) -> RxSwift.Observable<String> {
        event.onNext(.updateInfo(type: .goalWalk, content: goalWalk))
        return .just(goalWalk)
    }
    
    func updateUserInfo(userInfo: InfoModel) {
        self.userInfo = userInfo
    }
    
    func updateGoalInfo(goalInfo: GoalModel) {
        self.goalInfo = goalInfo
    }
}
