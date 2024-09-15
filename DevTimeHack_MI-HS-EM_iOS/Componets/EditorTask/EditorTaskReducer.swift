//
//  EditorTaskReducer.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

@MainActor func editorTaskReducer(_ state: inout EditorTaskState, _ action: EditorTaskAction) {
    switch action {
    case .editTask(taskID: let taskID):
        state.taskID = taskID
    case .successfully:
        state.isSuccessfully = true
    case .createTask, .updateTask:
        state.isSuccessfully = false
    default:
        break
    }
}
