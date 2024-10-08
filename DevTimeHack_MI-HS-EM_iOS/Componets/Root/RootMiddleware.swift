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
    let keychain = KeychainManager.shared
    let editorTaskMiddleware = editorTaskMiddleware()
    let service = BackendService.shared
    let userMiddleware = userMiddleware()
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
        case .editorTask(let action):
            guard let newAction = await editorTaskMiddleware(state.editortask, action) else {
                return nil
            }
            return .editorTask(newAction)
        case .user(let action):
            guard let newAction = await userMiddleware(state.userState, action) else {
                return nil
            }
            return .user(newAction)
        case .getUser:
            do {
                let user = try await service.getUser()
                return .setUser(user)
            } catch {
                print(error)
                return nil
            }
        default:
            break
        }
        return nil
    }
}
