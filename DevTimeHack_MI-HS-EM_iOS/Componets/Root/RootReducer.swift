//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

@MainActor func rootReducer(_ state: inout RootState, _ action: RootAction) {
    switch action {
    case .registration(let action):
        registrationReducer(&state.registrationState, action)
    case .login(let action):
        loginReducer(&state.loginState, action)
    case .user(let action):
        userReducer(&state.userState, action)
    case .editorTask(let action):
        editorTaskReducer(&state.editortask, action)
    case .setUser(let user):
        state.user = user
        state.isLogin = true
    default:
        break
    }
}
