//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

enum RootAction: ActionProtocol {
    case registration(RegistrationAction)
}

extension RootAction {
    private func caseIdentifier() -> String {
        let mirror = Mirror(reflecting: self)
        return String(describing: mirror.children.first?.label ?? "")
    }
}

extension RootAction: Hashable {
    static func == (lhs: RootAction, rhs: RootAction) -> Bool {
        lhs.caseIdentifier() == rhs.caseIdentifier()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.caseIdentifier())
    }
}
