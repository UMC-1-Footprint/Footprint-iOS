//
//  TestAPIManager.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/09/16.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

final class TestAPIManager {
//    func request(_ request: NetworkRequest) async throws -> [TestModel]? {
//        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//              let url = URL(string: encodedURL) else {
//            throw APIError.urlEncodingError
//        }
//
//        let (data, response) = try await URLSession.shared.data(for: request.createNetworkRequest(with: url))
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200..<500) ~= httpResponse.statusCode else {
//            throw APIError.serverError(error: "server Error")
//        }
//
//        let decodedData = try JSONDecoder().decode([TestModel].self, from: data)
////        print(decodedData)
//        return decodedData
//    }
    
    func request(_ request: NetworkRequest) -> Observable<[TestModel]?> {
        return Observable.create { observable in
            let task = URLSession.shared.dataTask(with: URL(string: request.url)!) { data, _, error in
                if let error = error { // 에러 처리
                    observable.onError(error)
                    return
                }
                guard let data = data, // 데이터가 있으면
                      let testModel = try? JSONDecoder().decode([TestModel].self, from: data) else { // JSon을 멤버배열로 파싱
                    observable.onCompleted() // 못 가져오면 완료처리
                    return
                }
                
                observable.onNext(testModel) // 데이터는 member배열을 전달
                observable.onCompleted() // 완료
            }
            task.resume() // URLSession 시작
            
            return Disposables.create { // 만약 dispose가 호출된다면
                task.cancel() // 동작 취소
            }
        }
    }
    
//    func request(_ request: NetworkRequest) -> Observable<[TestModel]?> {
//        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedURL) else { return .empty() }
//        return Observable.create { (observable) in
//            print("ddds")
//            let dataTask = URLSession.shared.dataTask(with: request.createNetworkRequest(with: url)) { (data, response, error)  in
//                print(error)
//                print(data)
//                do {
//                    if let data = data {
//                        let decodedData = try JSONDecoder().decode([TestModel].self, from: data)
//
//                        observable.onNext(decodedData)
//                    }
//                    print(data)
//                } catch {
//                    print(error)
//                }
//            }
//
//            URLSession.shared.dataTask(with: request.createNetworkRequest(with: url)) { (data, response, error)  in
//                print(error)
//                print(data)
//                do {
//                    if let data = data {
//                        let decodedData = try JSONDecoder().decode([TestModel].self, from: data)
//
//                        observable.onNext(decodedData)
//                    }
//                    print(data)
//                } catch {
//                    print(error)
//                }
//            }
//            return Disposables.create()
//        }
//    }
}
