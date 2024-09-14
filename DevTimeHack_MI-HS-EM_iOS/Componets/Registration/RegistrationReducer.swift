//
//  RegistrationReducer.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

@MainActor func registrationReducer(_ state: inout RegistrationState, _ action: RegistrationAction) {
    switch action {
    case .setToken(let token):
        print(token)
    default:
        break
    }
}
