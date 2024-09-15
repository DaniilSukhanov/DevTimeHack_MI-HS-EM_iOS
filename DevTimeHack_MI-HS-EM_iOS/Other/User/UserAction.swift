//
//  UserAction.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum UserAction: ActionProtocol {
    case startCheckingUser
    case stopCheckingUser(user: BSCurrentUser)
}
