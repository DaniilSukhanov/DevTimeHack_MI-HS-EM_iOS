//
//  BackendService.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

protocol BackendServiceProtocol: NetworkingProtocol {
    func registrationUser(username: String, email: String, password: String, repeatPassword: String) async throws
    func loginUser(login: String, password: String) async throws -> String
}

@globalActor
actor BackendService: BackendServiceProtocol {
    static let shared = BackendService()
    let baseURL = "http://127.0.0.1:8000"
    
    func registrationUser(username: String, email: String, password: String, repeatPassword: String) async throws {
        let queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "repeat_password", value: repeatPassword)
        ]
        try await "\(baseURL)/auth/register".sendRequest(typeMethod: .post, parameters: queryItems)
    }
    
    func loginUser(login: String, password: String) async throws -> String {
        let queryItems = [
            URLQueryItem(name: "username", value: login),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "grant_type", value: "password")
        ]
        let (data, _) = try await "\(baseURL)/auth/login".sendRequest(
            typeMethod: .post,
            headers: [
                "Content-Type": "application/x-www-form-urlencoded",
            ],
            body: "username=\(login)&password=\(password)".data(using: .utf8, allowLossyConversion: true)
        )
        return try BackendService.unpackToken(String(data: data, encoding: .utf8))
    }
}

extension BackendService {
    enum BackendServiceError: Error {
        case badToken
    }
}

fileprivate extension BackendService {
    static func unpackToken(_ token: String?) throws -> String {
        guard let token else {
            throw BackendServiceError.badToken
        }
        return token
    }
}

