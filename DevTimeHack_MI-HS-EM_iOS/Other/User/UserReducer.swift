//
//  UserReducer.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

@MainActor func userReducer(_ state: inout UserState, _ action: UserAction) {
    switch action {
    case .stopCheckingUser(let user):
        state.user = user
    default:
        break
    }
}
