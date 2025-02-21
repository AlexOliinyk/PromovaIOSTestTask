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
        categories()
    }
    
    private func categories() -> some View {
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
                .overlay {
                    if store.adShowed {
                        AdView()
                    }
                }
                .alert($store.scope(state: \.alert, action: \.alert))
                
            } destination: { (store) in
                switch store.case {
                case let .animalInfo(infoStore):
                    AnimalInfoView(store: infoStore)
                        .navigationTitle("Animal facts")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarRole(.editor)
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
