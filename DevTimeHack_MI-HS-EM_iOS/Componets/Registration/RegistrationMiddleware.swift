//
//  RegistrationMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func registrationMiddleware(
    service: BackendServiceProtocol = BackendService.shared,
    keychain: KeychainManagerProtocol = KeychainManager.shared
) -> Middleware<RegistrationState, RegistrationAction> {
    
    return { state, action in
        switch action {
        case .send(let username, let email, let password, let repeatPassword):
            do {
                try await service.registrationUser(
                    username: username, email: email,
                    password: password, repeatPassword: repeatPassword
                )
                let token = try await service.loginUser(login: username, password: password)
                try keychain.saveToken(token)
                return .successfully
            } catch {
                return .setError(error.localizedDescription)
            }
        default:
            return nil
        }
    }
}
