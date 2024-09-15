//
//  BackendService+Tasks.swift
//  DevTimeHack_MI-HS-EM_iOS
//
//  Created by Даниил Суханов on 15.09.2024.
//

import Foundation


struct BSTasks: Decodable {
    let total: Int
    let page: Int
    let results: [BSTask]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Декодируем глубже
        let bodyContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .body)
        let contentContainer = try bodyContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .content)
        let tasksContainer = try contentContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .tasks)
        
        // Извлекаем значения
        total = try tasksContainer.decode(Int.self, forKey: .total)
        page = try tasksContainer.decode(Int.self, forKey: .page)
        results = try tasksContainer.decode([BSTask].self, forKey: .results)
    }
    
    enum CodingKeys: String, CodingKey {
        case body
        case content
        case tasks
        case total
        case page
        case results
    }
}

struct BSTask: Decodable {
    let title: String
    let description: String?
    let taskStatus: String
    let taskImportance: Int
    let reminder: String?
    let attendant: String?
    let xp: String?
    
    enum CodingKeys: String, CodingKey {
        case title, description, reminder, attendant, xp
        case taskStatus = "task_status"
        case taskImportance = "task_importance"
    }
}


