//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

typealias Reducer<AppState: Sendable, AppAction: Sendable> = @MainActor (inout AppState, AppAction) -> ()
