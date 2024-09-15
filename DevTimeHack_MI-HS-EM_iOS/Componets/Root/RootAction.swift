//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum RootAction: ActionProtocol {
    case registration(RegistrationAction)
    case login(LoginAction)
}

