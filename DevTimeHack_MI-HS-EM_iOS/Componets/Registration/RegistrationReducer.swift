//
//  RegistrationReducer.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

@MainActor func registrationReducer(_ state: inout RegistrationState, _ action: RegistrationAction) {
    switch action {
    case .successfully:
        state.isSuccessfully = true
        state.error = nil
    case .setError(let text):
        state.isSuccessfully = false
        state.error = text
    default:
        break
    }
}
