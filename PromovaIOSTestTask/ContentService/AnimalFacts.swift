//
//  AnimalFacts.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 25/7/24.
//

import Foundation

typealias AnimalFacts = [AnimalFact]

// MARK: - AnimalFact
struct AnimalFact: Codable {
    let title, description: String
    let image: String
    let order: Int
    let status: String
    let content: [Content]?
}

// MARK: - Content
struct Content: Codable {
    let fact: String
    let image: String
}
