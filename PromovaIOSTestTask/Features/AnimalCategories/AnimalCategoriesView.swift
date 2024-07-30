//
//  AnimalCategoriesView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 28/7/24.
//

import ComposableArchitecture
import SwiftUI

struct AnimalCategoriesView: View {
    
    @Perception.Bindable var store: StoreOf<AnimalCategories>
    
    var body: some View {
            content()
    }
    
    private func content() -> some View {
        WithPerceptionTracking {
            NavigationStack(
                path: $store.scope(
                    state: \.selectedCategory,
                    action: \.info))
            {
                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        ForEach(store.categories) { category in
                            Button {
                                store.send(.categorieTapped(category.id))
                            } label: {
                                    CategoryCellView(animalFact: category)
                            }
                        }
                    }
                    .padding()
                }
                .background(Constants.backgroundColor)
                .onAppear(perform: {
                    store.send(.fetchAnimals)
                })
                .overlay(content: {
                    if store.isLoading {
                        ProgressView()
                    }
                })
                .alert($store.scope(state: \.alert, action: \.alert))
                .navigationTitle("Animal facts")
                .navigationBarTitleDisplayMode(.inline)
                
            } destination: { (store) in
                switch store.case {
                case let .animalInfo(infoStore):
                    AnimalInfoView(store: infoStore)
                }
            }
        }
    }
}

// MARK: - Extensions

extension AnimalCategoriesView {
    struct Constants {
        static let backgroundColor = Color(hex: "#BEC8FF")
    }
}

#Preview {
    AnimalCategoriesView(
        store: .init(
            initialState: AnimalCategories.State(),
            reducer: { AnimalCategories() }
        )
    )
}
