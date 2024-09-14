//
//  DevTimeHack_MI_HS_EM_iOSApp.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

@main
struct DevTimeHack_MI_HS_EM_iOSApp: App {
    @StateObject var store = createRootStore()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}
