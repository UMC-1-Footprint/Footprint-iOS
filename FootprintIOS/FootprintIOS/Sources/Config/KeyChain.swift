//
//  KeyChain.swift
//  Footprint-iOS
//
//  Created by Sojin Lee on 2022/10/06.
//  Copyright © 2022 Footprint-iOS. All rights reserved.
//

import Foundation

class KeyChain {
    // MARK: - 항목 추가
    func createKeyChain(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)
        
        // TODO: - 밑의 작업이 main thread의 실행을 막을 수 있으니 DispatchQueue.global(qos: .background) {}  에서 실행되도록 리팩토링 하기
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    // MARK: - 키체인 항목 반환
    func readKeyChain(key: String) -> String? {
        let query: NSDictionary = [
                    kSecClass: kSecClassGenericPassword,
                    kSecAttrAccount: key,
                    kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
                    kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
                ]
                
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef) // 조건에 맞는 키체인을 반환.
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    // MARK: - 키체인 삭제 
    func deleteKeyChain(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}
