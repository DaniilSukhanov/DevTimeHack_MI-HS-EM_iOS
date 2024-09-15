//
//  UserMiddleware.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

func userMiddleware(
    service: BackendService = BackendService.shared,
    keychain: KeychainManagerProtocol = KeychainManager.shared
) -> Middleware<UserState, UserAction> {
    return { state, action in
        switch action {
        case .startCheckingUser:
            guard let user = try? await service.getUser() else {
                try? await Task.sleep(for: .seconds(2))
                return .startCheckingUser
            }
            return .stopCheckingUser(user: user)
        default:
            break
        }
        return nil
    }
}
