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
                
                VStack {
                    PageView(
                        pageCount: store.facts.count,
                        currentIndex: $store.selectedItem.sending(\.infoTabChanged)
                    ) {
                        ForEachStore(self.store.scope(
                            state: \.facts,
                            action: AnimalInfo.Action.info)
                        ) { infoCellStore in
                            VStack {
                                AnimalInfoCellView(store: infoCellStore)
                                    .padding(.top, 50)
                                    .padding(.horizontal, 22)
                                .padding(.bottom, 50)
                                
                                Spacer()
                                
                                shareButton(image: infoCellStore.imageLink, description: infoCellStore.description)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func shareButton(image: String, description: String) -> some View {
        ShareLink(item: URL(string: image)!, message: Text(description)) {
            Image(systemName: "square.and.arrow.up.circle")
                .foregroundStyle(.black)
                .font(.system(size: 50))
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
