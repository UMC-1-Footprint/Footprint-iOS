//
//  APIManager.swift
//  Footprint-iOSTests
//
//  Created by Sojin Lee on 2022/09/14.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation
import RxSwift

protocol Requestable: AnyObject {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}

final class APIManager: Requestable {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T? {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL) else {
            throw APIError.urlEncodingError
        }

        let (data, response) = try await URLSession.shared.data(for: request.createNetworkRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode else {
            throw APIError.serverError(error: "server Error")
        }

        let decodedData = try JSONDecoder().decode(BaseModel<T>.self, from: data)
        if decodedData.isSuccess {
            return decodedData.result
        } else {
            throw APIError.clientError(error: decodedData.message)
        }
    }
}
