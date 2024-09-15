//
//  TokenManager.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

protocol KeychainManagerProtocol {
    func getToken() throws -> String
    func saveToken(_ token: String) throws
}

enum KeychainError : Error {
    case unknow(status: OSStatus)
    case badToken
}

final class KeychainManager: KeychainManagerProtocol {
    static let shared = KeychainManager()
    
    func getToken() throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "user",
            kSecReturnData: kCFBooleanTrue as Any
        ]
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            throw KeychainError.unknow(status: status)
        }
        guard let data = result as? Data, let token = String(data: data, encoding: .utf8) else {
            throw KeychainError.badToken
        }
        return token
    }
    
    func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.badToken
        }
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "user",
            kSecValueData: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknow(status: status)
        }
    }
}
