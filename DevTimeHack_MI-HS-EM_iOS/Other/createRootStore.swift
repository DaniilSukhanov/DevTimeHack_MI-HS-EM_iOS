//
//  Store+create.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

typealias RootStore = Store<RootState, RootAction>

@MainActor func createRootStore() -> RootStore {
    RootStore(
        state: RootState(),
        reducer: rootReducer,
        middlewares: [rootMiddleware()]
    )
}

