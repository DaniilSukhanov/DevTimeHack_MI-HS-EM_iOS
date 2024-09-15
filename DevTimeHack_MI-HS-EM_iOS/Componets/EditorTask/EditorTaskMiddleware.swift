//
//  EditorTaskMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func editorTaskMiddleware(
    service: BackendService = BackendService.shared,
    keychain: KeychainManagerProtocol = KeychainManager.shared
) -> Middleware<EditorTaskState, EditorTaskAction> {
    return { state, action in
        switch action {
        case .createTask(name: let name, deadline: let deadline, text: let text):
            do {
                try await service.createTask(
                    title: name, attendantID: 0, description: text,
                    taskStatus: nil, taskImportance: nil, xp: nil, reminder: deadline
                )
                return .successfully
            } catch {
                print(error)
                return nil
            }
        case .updateTask(name: let name, deadline: let deadline, text: let text):
            do {
                try await service.updateTask(taskID: 0, title: name, description: text, attendantID: 0, taskStatus: nil, taskImportance: nil, xp: nil, reminder: deadline)
                return .successfully
            } catch {
                print(error)
                return nil
            }
        default:
            break
        }
        return nil
    }
}
