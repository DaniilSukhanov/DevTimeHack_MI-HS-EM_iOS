//
//  ContentView.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

protocol ActionProtocol: Sendable {
    
}

extension ActionProtocol {
    var description: String {
        String(describing: self)
    }
}


