//
//  APIProvider.swift
//  Footprint-iOS
//
//  Created by 송영모 on 2022/12/28.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

protocol APIProviderType {
    func request<T: Decodable>(request: NetworkRequest) -> Observable<T>
}

class APIProvider: BaseProvider, APIProviderType {
    func request<T: Decodable>(request: NetworkRequest) -> Observable<T> {
        return Observable.create { observable in
            guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: encodedURL) else {
                return Disposables.create {
                    observable.onError(APIError.urlEncodingError)
                }
            }
            print("-------------- \(encodedURL) --------------")
            
            let task = URLSession.shared.dataTask(with: request.createNetworkRequest(with: url)) { data, response, error in
               
                if let error = error {
                    print("-------------- \(error) --------------")
                    observable.onError(error)
                    return
                }
                
                guard let data = data,
                      let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("-------------- decode fail --------------")
                    observable.onCompleted()
                    return
                }
                
                observable.onNext(responseData as T)
                observable.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

