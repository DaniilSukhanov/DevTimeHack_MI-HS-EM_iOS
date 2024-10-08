//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

struct RootState: StateProtocol {
    var registrationState = RegistrationState()
    var loginState = LoginState()
    var userState = UserState()
    var editortask = EditorTaskState()
    var isLogin = false
    var user: BSCurrentUser?
}
