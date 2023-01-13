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
    
    func requestInfo(userInfo: UserInfoRequestModel, goalInfo: GoalInfoDTO)
    func updateBirth(to birth: String) -> Observable<String>
    func updateWalk(to walk: String) -> Observable<String>
    func updateGoalWalk(to goalWalk: String) -> Observable<String>
}

class InfoService: NetworkService, InfoServiceProtocol {
    
    let event = PublishSubject<InfoEvent>()
    
    func requestInfo(userInfo: UserInfoRequestModel, goalInfo: GoalInfoDTO) {
        let request = InfoEndPoint
            .requestUserInfo(
                userInfo: InfoRequestDTO(
                    nickname: userInfo.nickname,
                    sex: userInfo.sex,
                    birth: userInfo.birth,
                    height: Int(userInfo.height ?? "0") ?? 0,
                    weight: Int(userInfo.weight ?? "0") ?? 0,
                    dayIdx: goalInfo.dayIdx,
                    walkGoalTime: goalInfo.walkGoalTime,
                    walkTimeSlot: goalInfo.walkTimeSlot))
            .createRequest()
        
        let response: Single<DefaultResponse> = API.request(request: request)
        
        response.asObservable()
            .map(\.message)
            .bind { data in
                print("\(data)")
            }
            .disposed(by: disposeBag)
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
}
