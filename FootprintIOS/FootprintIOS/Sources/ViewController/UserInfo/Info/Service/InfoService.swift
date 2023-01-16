//
//  InfoService.swift
//  Footprint-iOS
//
//  Created by 김영인 on 2022/12/02.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import RxSwift

enum InfoEvent {
    case updateBirth(content: String)
    case updateWalk(content: String)
    case updateGoalWalk(content: String)
}

protocol InfoServiceProtocol {
    var event: PublishSubject<InfoEvent> { get }
    
    func createInfo()
    func editGoalInfo()
    func updateBirth(to birth: String) -> Observable<String>
    func updateWalk(to walk: String) -> Observable<String>
    func updateGoalWalk(to goalWalk: String) -> Observable<String>
    func updateUserInfo(userInfo: InfoModel)
    func updateGoalInfo(goalInfo: GoalInfoDTO)
}

class InfoService: InfoServiceProtocol {
    let event = PublishSubject<InfoEvent>()
    
    private var userInfo: InfoModel?
    private var goalInfo: GoalInfoDTO?
    
    func createInfo() {
        // 서버 통신
        print(self.userInfo)
        print(self.goalInfo)
    }
    
    func editGoalInfo() {
        print(self.goalInfo)
    }
    
    func updateBirth(to birth: String) -> Observable<String> {
        event.onNext(.updateBirth(content: birth))
        return .just(birth)
    }
    
    func updateWalk(to walk: String) -> Observable<String> {
        event.onNext(.updateWalk(content: walk))
        return .just(walk)
    }
    
    func updateGoalWalk(to goalWalk: String) -> Observable<String> {
        event.onNext(.updateGoalWalk(content: goalWalk))
        return .just(goalWalk)
    }
    
    func updateUserInfo(userInfo: InfoModel) {
        self.userInfo = userInfo
    }
    
    func updateGoalInfo(goalInfo: GoalInfoDTO) {
        self.goalInfo = goalInfo
    }
}
