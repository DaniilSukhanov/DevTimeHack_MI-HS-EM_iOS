//
//  BackendServiceProtocol.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum TaskStatus: String {
    case planning, running, done, cancelled
}

enum TaskImportance: Int {
    case common = 1, important, extremelyImportant
}

protocol BackendServiceProtocol: NetworkingProtocol {
    
    func registrationUser(username: String, email: String, password: String, repeatPassword: String) async throws
    func loginUser(login: String, password: String) async throws -> String
    func createTask(
        title: String, attendantID: Int, description: String?,
        taskStatus: TaskStatus?,
        taskImportance: TaskImportance?, xp: Int?, reminder: Date?
    ) async throws
    func getPersonalsTasks(page: Int, limit: Int?, status: TaskStatus?, importance: TaskImportance?) async throws -> BSTasks
    func updateTask(
        taskID: Int, title: String, description: String?,
        attendantID: Int, taskStatus: TaskStatus?,
        taskImportance: TaskImportance?, xp: Int?, reminder: Date?
    ) async throws
}
