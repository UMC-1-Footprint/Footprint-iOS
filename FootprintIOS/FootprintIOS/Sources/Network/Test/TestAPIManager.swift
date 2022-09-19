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
    func request(_ request: NetworkRequest) -> Observable<[TestModel]?> {
        return Observable.create { observable in
            guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: encodedURL) else {
                return Disposables.create {
                    observable.onError(APIError.urlEncodingError)
                }
            }
            
            let task = URLSession.shared.dataTask(with: request.createNetworkRequest(with: url)) { data, response, error in
                if let error = error {
                    observable.onError(error)
                    return
                }
                guard let data = data,
                      let testModel = try? JSONDecoder().decode([TestModel].self, from: data) else {
                    observable.onCompleted()
                    return
                }
                observable.onNext(testModel)
                observable.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
