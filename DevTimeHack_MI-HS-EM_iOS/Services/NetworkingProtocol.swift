//
//  NetworkingProtocol.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

protocol NetworkingProtocol: Actor {
    var baseURL: String { get }
}
