//
//  LoginMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func loginMiddleware(
    service: BackendServiceProtocol = BackendService.shared,
    keychain: KeychainManagerProtocol = KeychainManager.shared
) -> Middleware<LoginState, LoginAction> {
    return { state, action in
        switch action {
        case .send(login: let login, password: let password):
            do {
                let token = try await service.loginUser(login: login, password: password)
                try keychain.saveToken(token)
            } catch {
                return .setError(error.localizedDescription)
            }
        default:
            break
        }
        return nil
    }
}
