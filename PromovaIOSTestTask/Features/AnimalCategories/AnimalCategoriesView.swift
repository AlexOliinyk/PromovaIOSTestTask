//
//  AnimalCategoriesView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 28/7/24.
//

import ComposableArchitecture
import SwiftUI

struct AnimalCategoriesView: View {
    
    let store: StoreOf<AnimalCategories>
    
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .ignoresSafeArea(.all, edges: .all)
            content()
        }
    }
    
    private func content() -> some View {
        WithPerceptionTracking {
            ZStack {
                rowsContent()
                
                if store.state.isLoading {
                    ProgressView()
                        .scaleEffect(2.0)
                }
            }
            .onAppear(perform: {
                store.send(.fetchAnimals)
            })
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
