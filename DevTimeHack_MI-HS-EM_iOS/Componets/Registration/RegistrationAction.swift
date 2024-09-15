//
//  RegistrationAction.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum RegistrationAction: ActionProtocol {
    case send(username: String, email: String, password: String, repeatPassword: String)
    case successfully
    case setError(String)
}
