//
//  AnimalInfoView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 30/7/24.
//

import SwiftUI
import ComposableArchitecture

struct AnimalInfoView: View {
    
    @Perception.Bindable var store: StoreOf<AnimalInfo>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                AnimalCategoriesView.Constants.backgroundColor
                    .ignoresSafeArea(.all, edges: .all)
                
                ForEachStore(self.store.scope(
                    state: \.facts,
                    action: AnimalInfo.Action.info)
                ) { store in
                    AnimalInfoCellView(store: store)
                        .padding(.top, 50)
                        .padding(.horizontal, 22)
                        .padding(.bottom, 50)
                }
            }
        }
    }
}

#Preview {
    AnimalInfoView(
        store: Store(
            initialState: AnimalInfo.State(animalFact: .mockPaid),
            reducer: { AnimalInfo() }
        )
    )
}
