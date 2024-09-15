//
//  EditorTaskAction.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum EditorTaskAction: ActionProtocol {
    case editTask(taskID: Int?)
    case createTask(name: String, deadline: Date, text: String)
    case updateTask(name: String, deadline: Date, text: String)
    case successfully
}
