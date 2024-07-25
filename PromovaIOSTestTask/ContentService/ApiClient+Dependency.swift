//
//  ApiClient+Dependency.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 25/7/24.
//

import Foundation
import ComposableArchitecture

struct ApiClient {
    var fetchAnimals: () async throws -> AnimalFacts
    
    struct Failure: Error {}
}

extension DependencyValues {
    var apiClient: ApiClient {
        get { self[ApiClient.self] }
        set { self[ApiClient.self] = newValue }
    }
}

extension ApiClient: DependencyKey {
    
    static var liveValue = ApiClient {
        let (data, _) = try await URLSession.shared.data(from: ContentUrl.url)
        let animalFacts = try JSONDecoder().decode(AnimalFacts.self, from: data)
        return animalFacts
    }
}

extension ApiClient: TestDependencyKey {
    static var testValue: ApiClient {
        unimplemented()
    }
}
