//
//  BackendService.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation
import OSLog

@globalActor
actor BackendService {
    static let shared = BackendService()
    let baseURL = "http://127.0.0.1:8000"
    private let logger = Logger(subsystem: "BackendService", category: "Networking")
    private let keychein = KeychainManager.shared
    
    private let dateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    private let jsonDecoder = JSONDecoder()
    
    func createTask(title: String, attendantID: Int, description: String?, taskStatus: TaskStatus?, taskImportance: TaskImportance?, xp: Int?, reminder: Date?) async throws {
        var deadline: String? = nil
        if let reminder {
            deadline = dateFormatter.string(from: reminder)
        }
        let queryItems = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "description", value: title),
            URLQueryItem(name: "attendant_id", value: String(attendantID)),
            URLQueryItem(name: "task_status", value: taskStatus?.rawValue),
            URLQueryItem(name: "task_importance", value: String(taskImportance?.rawValue ?? 1)),
            URLQueryItem(name: "xp", value: String(xp ?? 0)),
            URLQueryItem(name: "reminder", value: deadline)
            
        ]
        try await "\(baseURL)/create_task".sendRequest(
            typeMethod: .post, parameters: queryItems,
            headers: [:].addToken(try keychein.getToken())
        )
    }
    
    func registrationUser(username: String, email: String, password: String, repeatPassword: String) async throws {
        logger.debug("registration user")
        try await "\(baseURL)/auth/register".sendRequest(
            typeMethod: .post,
            headers: [
                "Content-Type": "application/x-www-form-urlencoded",
            ],
            body: "username=\(username)&password=\(password)&email=\(email)&repeat_password=\(repeatPassword)".data(using: .utf8, allowLossyConversion: true)
        )
    }
    
    func loginUser(login: String, password: String) async throws -> String {
        logger.debug("login user")
        let (data, _) = try await "\(baseURL)/auth/login".sendRequest(
            typeMethod: .post,
            headers: [
                "Content-Type": "application/x-www-form-urlencoded",
            ],
            body: "username=\(login)&password=\(password)".data(using: .utf8, allowLossyConversion: true)
        )
        return try BackendService.unpackToken(data: data)
    }
    
    func getPersonalsTasks(page: Int, limit: Int?, status: TaskStatus?, importance: TaskImportance?) async throws -> BSTasks {
        let queryItems = [
            URLQueryItem(name: "page", value: ""),
            URLQueryItem(name: "limit", value: String(limit ?? 10)),
            URLQueryItem(name: "status", value: status?.rawValue),
            URLQueryItem(name: "importance", value: String(importance?.rawValue ?? 1))
        ]
        let (data, _) = try await "\(baseURL)/tasks".sendRequest(parameters: queryItems, headers: [:].addToken(try keychein.getToken()))
        return try jsonDecoder.decode(BSTasks.self, from: data)
    }
    
    func updateTask(
        taskID: Int, title: String, description: String?,
        attendantID: Int, taskStatus: TaskStatus?, taskImportance: TaskImportance?,
        xp: Int?, reminder: Date?
    ) async throws {
        var deadline: String? = nil
        if let reminder {
            deadline = dateFormatter.string(from: reminder)
        }
        let queryItems = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "description", value: title),
            URLQueryItem(name: "attendant_id", value: String(attendantID)),
            URLQueryItem(name: "task_status", value: taskStatus?.rawValue),
            URLQueryItem(name: "task_importance", value: String(taskImportance?.rawValue ?? 1)),
            URLQueryItem(name: "xp", value: String(xp ?? 0)),
            URLQueryItem(name: "reminder", value: deadline)
            
        ]
        try await "\(baseURL)/\(taskID)".sendRequest(
            typeMethod: .put, parameters: queryItems,
            headers: [:].addToken(try keychein.getToken())
        )
    }
    
    func getUser() async throws -> BSCurrentUser {
        let (data, _) = try await "\(baseURL)/users/whoami".sendRequest(headers: [:].addToken(try keychein.getToken()))
        return try jsonDecoder.decode(BSCurrentUser.self, from: data)
    }
    
    func updateToken() async throws -> String {
        let (data, _) = try await "\(baseURL)/auth/update_token".sendRequest(typeMethod: .post, headers: [:].addToken(try keychein.getToken()))
        return try BackendService.unpackToken(data: data)
    }
}

extension BackendService {
    enum TaskStatus: String {
        case planning, running, done, cancelled
    }
    
    enum TaskImportance: Int {
        case common = 1, important, extremelyImportant
    }
}

extension BackendService {
    enum BackendServiceError: Error {
        case badToken, badFormatJSON
    }
}

fileprivate extension BackendService {
    static func unpackToken(data: Data) throws -> String {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: String] else {
            throw BackendServiceError.badFormatJSON
        }
        guard let token = json["access_token"] else {
            throw BackendServiceError.badFormatJSON
        }
        return token
    }
}

fileprivate extension Dictionary where Key == String, Value == String {
    func addToken(_ token: String) -> Self {
        var copy = self
        copy["Authorization"] = "Bearer \(token)"
        return copy
    }
}
