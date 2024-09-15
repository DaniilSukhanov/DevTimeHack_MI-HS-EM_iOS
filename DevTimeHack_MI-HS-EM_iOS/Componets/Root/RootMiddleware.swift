//
//  RootMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func rootMiddleware() -> Middleware<RootState, RootAction> {
    let registrationMiddleware = registrationMiddleware()
    let loginMiddleware = loginMiddleware()
    return { state, action in
        switch action {
        case .registration(let action):
            guard let newAction = await registrationMiddleware(state.registrationState, action) else {
                return nil
            }
            return .registration(newAction)
        case .login(let action):
            guard let newAction = await loginMiddleware(state.loginState, action) else {
                return nil
            }
            return .login(newAction)
        }
    }
}
