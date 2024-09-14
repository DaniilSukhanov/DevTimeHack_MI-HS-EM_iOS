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
    }
}
