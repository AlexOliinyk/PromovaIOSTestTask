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
            NavigationStack {
                ZStack {
                    rowsContent()
                    
                    if store.state.isLoading {
                        ProgressView()
                            .scaleEffect(2.0)
                    }
                }
                .background(Constants.backgroundColor)
                .onAppear(perform: {
                    store.send(.fetchAnimals)
                })
                .alert($store.scope(state: \.alert, action: \.alert))
            }
        }
    }
    
    private func rowsContent() -> some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                ForEach(store.categories) { category in
                    categoryRow(with: category)
                }
            }
            .padding()
        }
        .navigationTitle("Animal facts")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func categoryRow(with category: AnimalFact) -> some View {
//        NavigationLink {
//            IfLetStore(self.store.scope(
//                state: \.selectedCategory,
//                action: \.info)) { infoStore in
//                AnimalInfoView(store: infoStore)
//            }
//        } label: {
//            <#code#>
//        }

            CategoryCellView(animalFact: category)
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
