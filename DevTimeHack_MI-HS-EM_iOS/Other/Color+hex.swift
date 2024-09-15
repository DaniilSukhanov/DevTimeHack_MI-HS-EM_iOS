//
//  Color+hex.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.09.2024.
//

import SwiftUI

extension Color {
    init(hex: Int) {
        self.init(uiColor: .init(hex: hex))
    }
}
