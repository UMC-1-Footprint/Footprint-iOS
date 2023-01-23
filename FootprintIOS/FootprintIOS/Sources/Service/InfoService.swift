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
    
    case getThisMonthGoal(GoalResponseDTO)
    case getNextMonthGoal(GoalResponseDTO)
    case patchNextMonthGoal(Bool)
}

protocol InfoServiceProtocol {
    var event: PublishSubject<InfoEvent> { get }
    
    func postUserInfo(userInfo: UserInfoRequestModel, goalInfo: GoalRequestDTO)
    func getThisMonthGoal()
    func getNextMonthGoal()
    func patchNextMonthGoal(goalInfo: GoalRequestDTO)
    func updateBirth(to birth: String) -> Observable<String>
    func updateWalk(to walk: String) -> Observable<String>
    func updateGoalWalk(to goalWalk: String) -> Observable<String>
}

class InfoService: NetworkService, InfoServiceProtocol {
    let event = PublishSubject<InfoEvent>()
    
    func postUserInfo(userInfo: UserInfoRequestModel, goalInfo: GoalRequestDTO) {
        let request = InfoEndPoint
            .postUserInfo(
                userInfo: InfoRequestDTO(
                    nickname: userInfo.nickname,
                    sex: userInfo.sex,
                    birth: userInfo.birth,
                    height: Int(userInfo.height ?? "0") ?? nil,
                    weight: Int(userInfo.weight ?? "0") ?? nil,
                    dayIdx: goalInfo.dayIdx,
                    walkGoalTime: goalInfo.walkGoalTime,
                    walkTimeSlot: goalInfo.walkTimeSlot))
            .createRequest()
        
        API.request(request: request)
            .asObservable()
            .map(\DefaultResponse.message)
            .bind {
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    func getThisMonthGoal() {
        let request = InfoEndPoint
            .getThisMonth
            .createRequest()
        
        API.request(request: request)
            .asObservable()
            .map(\BaseModel.result)
            .bind { [weak self] data in
                self?.event.onNext(.getThisMonthGoal(data))
            }
            .disposed(by: disposeBag)
    }
    
    func getNextMonthGoal() {
        let request = InfoEndPoint
            .getNextMonth
            .createRequest()
        
        API.request(request: request)
            .asObservable()
            .map(\BaseModel.result)
            .bind { [weak self] data in
                self?.event.onNext(.getNextMonthGoal(data))
            }
            .disposed(by: disposeBag)
    }
    
    func patchNextMonthGoal(goalInfo: GoalRequestDTO) {
        let request = InfoEndPoint
            .patchNextMonthGoal(goalInfo: goalInfo)
            .createRequest()
        
        API.request(request: request)
            .asObservable()
            .map(\DefaultResponse.isSuccess)
            .bind { [weak self] isSuccess in
                self?.event.onNext(.patchNextMonthGoal(isSuccess))
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
