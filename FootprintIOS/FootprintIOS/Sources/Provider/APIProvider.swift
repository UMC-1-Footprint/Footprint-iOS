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
    func request<T: Decodable>(request: NetworkRequest) -> Single<T>
}

class APIProvider: BaseProvider, APIProviderType {
    func request<T: Decodable>(request: NetworkRequest) -> Single<T> {
        return Single<T>.create { single in
            print("==============[willSend]==============")
            guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: encodedURL) else {
                return Disposables.create {
                    print("[Logger - ✅ result] ❌ url encoding error")
                    
                    single(.failure(APIError.urlEncodingError))
                }
            }
            
            print("[Logger - ✅ Header] \(String(describing: request.headers))")
            print("[Logger - ✅ Body] \(String(describing: String(data: request.body ?? Data(), encoding: .utf8)))")
            print("[Logger - ✅ Endpoint] [\(String(describing: request.httpMethod.rawValue))] - \(String(describing: request.url))")
            
            let task = URLSession.shared.dataTask(with: request.createNetworkRequest(with: url)) { data, response, error in
               
                if let error = error {
                    
                    single(.failure(error))
                    return
                }
                
                print("==============[didReceive]==============")
                print("[Logger - ✅ request] \(request.url)")
                guard let data = data else {
                    print("[Logger - ✅ result] ❌ FAILURE")
                    
                    single(.failure(APIError.jsonParsingError))
                    return
                }
                
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    print("[Logger - ✅ result] ⭕️ SUCCESS")
                    print(responseData)
                    
                    single(.success(responseData))
                } catch {
                    print("[Logger - ✅ result] ❌ FAILURE")
                    print(error)
                    
                    single(.failure(APIError.jsonParsingError))
                    return
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
