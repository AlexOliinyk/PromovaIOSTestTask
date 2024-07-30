//
//  AnimalInfo.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalInfo {
    
    @ObservableState
    struct State: Identifiable {
        var id: UUID
        var title: String
        var facts: IdentifiedArrayOf<AnimalInfoCell.State>
        var selectedItem: Int
        
        init(animalFact: AnimalFact) {
            self.id = animalFact.id
            self.title = animalFact.title
            
            let content = animalFact.content.enumerated().map { index, fact in
                AnimalInfoCell.State(
                    animalFact: fact,
                    index: index,
                    previousButtonEnable: index > 0,
                    nextButtonEnabled: index < animalFact.content.count - 1
                )
            }
            
            self.facts = IdentifiedArray(uniqueElements: content)
            selectedItem = .zero
        }
        
    }
    
    enum Action {
        case infoTabChanged(Int)
        case info(index: AnimalInfoCell.State.ID, action: AnimalInfoCell.Action)
        case goToNext
        case goToPrevious
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case let .infoTabChanged(itemId):
                state.selectedItem = itemId
                return .none
            case .info(_, action: let action):
                switch action {
                    
                case .previousButtonTapped(_):
                    return .send(.goToPrevious, animation: .interactiveSpring)
                case .nextButtonTapped(_):
                    return .send(.goToNext, animation: .interactiveSpring)
                }
            case .goToNext:
//                let currentItem = state.selectedItem
                state.selectedItem += 1
                return .none
            case .goToPrevious:
                state.selectedItem -= 1
                return .none
            }
        }
    }
}
