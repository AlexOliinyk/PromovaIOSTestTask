//
//  AnimalFacts.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 25/7/24.
//

import Foundation

typealias AnimalFacts = [AnimalFact]

// MARK: - AnimalFact
struct AnimalFact: Codable, Identifiable {
    let id: UUID
    let title, description: String
    let image: String
    let order: Int
    let status: Status
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let fact: String
    let image: String
    let id: UUID
}

// MARK: - Extensions

extension AnimalFact {
    enum Status: String, Codable {
        case free
        case paid
        case comingSoon
    }
}

extension AnimalFact {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.order = try container.decode(Int.self, forKey: .order)
        self.content = try container.decodeIfPresent([Content].self, forKey: .content) ?? []
        self.status = content.isEmpty ? .comingSoon : try container.decode(Status.self, forKey: .status)
        self.id = UUID()
    }
}

extension Content {
    enum CodingKeys: String, CodingKey {
        case fact
        case image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fact = try container.decode(String.self, forKey: .fact)
        self.image = try container.decode(String.self, forKey: .image)
        self.id = UUID()
    }
}
