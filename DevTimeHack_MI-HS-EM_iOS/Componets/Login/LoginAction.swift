//
//  LoginAction.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum LoginAction: ActionProtocol {
    case setError(String)
    case successfully
    case send(login: String, password: String)
}
