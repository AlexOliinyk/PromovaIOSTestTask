//
//  AnimalInfoCellView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import SwiftUI
import ComposableArchitecture

struct AnimalInfoCellView: View {
    
    @Perception.Bindable var store: StoreOf<AnimalInfoCell>
    
    var body: some View {
        WithPerceptionTracking {
            GeometryReader { proxy in
                VStack(alignment: .center) {
                    image(url: store.imageLink,
                          height: proxy.size.height)
                    
                    title(with: store.description)
                    
                    Spacer()
                    
                    buttons()
                }
                .background(.white)
                .cornerRadius(10.0)
            }
        }
    }
    
    private func image(url: String, height: CGFloat) -> some View {
        ImagePlaceholder(url: url)
            .frame(height: height * 0.5)
            .aspectRatio(contentMode: .fill)
            .fixedSize(horizontal: false, vertical: true)
            .clipped()
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.bottom, 17)
    }
    
    private func title(with title: String) -> some View {
        Text(title)
            .font(.body)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
    
    private func buttons() -> some View {
        HStack {
            Button {
                store.send(.previousButtonTapped(store.index))
            } label: {
                cellButton(element: "chevron.left")
            }
            .disabled(!store.previousButtonEnable)
            .foregroundStyle(store.previousButtonEnable ? .black : .gray)
            
            Spacer()
            
            Button {
                store.send(.nextButtonTapped(store.index))
            } label: {
                cellButton(element: "chevron.right")
            }
            .disabled(!store.nextButtonEnabled)
            .foregroundStyle(store.nextButtonEnabled ? .black : .gray)
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 20)
    }
    
    private func cellButton(element: String) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3.0)
            Image(systemName: element)
                .font(.system(size: 22, weight: .semibold))
        }
        .frame(width: 55)
    }
}

#Preview {
    AnimalInfoCellView(
        store: Store(
            initialState: AnimalInfoCell.State(
                animalFact: .paidMock[0], 
                index: 0
            ),
            reducer: { AnimalInfoCell() }
        )
    )
    .padding(.horizontal, 22)
    .padding(.top, 50)
    .padding(.bottom, 100)
    .background(AnimalCategoriesView.Constants.backgroundColor)
}
