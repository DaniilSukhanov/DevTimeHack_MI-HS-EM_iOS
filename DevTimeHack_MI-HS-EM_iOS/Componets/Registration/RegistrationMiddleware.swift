//
//  RegistrationMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func registrationMiddleware(
    service: BackendServiceProtocol = BackendService.shared
) -> Middleware<RegistrationState, RegistrationAction> {
    
    return { state, action in
        switch action {
        case .send(let username, let email, let password, let repeatPassword):
            do {
                try? await service.registrationUser(
                    username: username, email: email,
                    password: password, repeatPassword: repeatPassword
                )
                let token = try await service.loginUser(login: username, password: password)
                return .setToken(token)
            } catch {
                print(String(describing: error))
                return nil
            }
        default:
            return nil
        }
    }
}
// 123D&d93
// R21@gdds.com
// Test1
