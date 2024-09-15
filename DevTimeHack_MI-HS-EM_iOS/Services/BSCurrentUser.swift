//
//  BSCurrentUser.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation

struct BSCurrentUser: Decodable {
    let username: String
    let email: String
    let tokenDateValid: String?
    let id: Int
    let password: String
    let image: Data?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Декодируем глубже
        let bodyContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .body)
        let contentContainer = try bodyContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .content)
        let userContainer = try contentContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        
        // Извлекаем значения
        username = try userContainer.decode(String.self, forKey: .username)
        email = try userContainer.decode(String.self, forKey: .email)
        tokenDateValid = try userContainer.decodeIfPresent(String.self, forKey: .tokenDateValid)
        id = try userContainer.decode(Int.self, forKey: .id)
        password = try userContainer.decode(String.self, forKey: .password)
        image = try userContainer.decodeIfPresent(Data.self, forKey: .image)
    }
    
    enum CodingKeys: String, CodingKey {
        case body
        case content
        case user
        case username
        case email
        case tokenDateValid = "token_date_valid"
        case id
        case password
        case image
    }
}
