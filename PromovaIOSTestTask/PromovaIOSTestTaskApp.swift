//
//  PromovaIOSTestTaskApp.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 25/7/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct PromovaIOSTestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            AnimalCategoriesView(store: Store(initialState: AnimalCategories.State(), reducer: { AnimalCategories() }))
        }
    }
}
