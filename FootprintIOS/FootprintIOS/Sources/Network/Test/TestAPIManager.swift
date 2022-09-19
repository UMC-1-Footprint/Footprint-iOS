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
    func request(_ request: NetworkRequest) async throws -> [TestModel]? {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL) else {
            throw APIError.urlEncodingError
        }

        let (data, response) = try await URLSession.shared.data(for: request.createNetworkRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode else {
            throw APIError.serverError(error: "server Error")
        }

        let decodedData = try JSONDecoder().decode([TestModel].self, from: data)
//        print(decodedData)
        return decodedData
        
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
