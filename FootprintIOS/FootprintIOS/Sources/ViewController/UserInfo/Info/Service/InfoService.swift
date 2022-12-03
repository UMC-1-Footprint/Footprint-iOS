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
    
    func updateBirth(to birth: String) -> Observable<String>
    func updateUserInfo(userInfo: InfoModel)
    func updateGoalInfo(goalInfo: GoalModel)
}

class InfoService: InfoServiceProtocol {
    let event = PublishSubject<InfoEvent>()
    
    private var userInfo: InfoModel?
    private var goalInfo: GoalModel?
    
    func createInfo() {
        // 서버 통신
    }
    
    func updateBirth(to birth: String) -> Observable<String> {
        event.onNext(.updateInfo(type: .birth, content: birth))
        return .just(birth)
    }
    
    func updateUserInfo(userInfo: InfoModel) {
        self.userInfo = userInfo
    }
    
    func updateGoalInfo(goalInfo: GoalModel) {
        self.goalInfo = goalInfo
    }
}
