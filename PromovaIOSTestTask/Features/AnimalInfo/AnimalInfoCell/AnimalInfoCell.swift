//
//  AnimalInfoCell.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalInfoCell {
    
    @ObservableState
    struct State: Identifiable {
        let id: UUID
        let index: Int
        let imageLink: String
        let description: String
        let previousButtonEnable: Bool
        let nextButtonEnabled: Bool
        
        public init(animalFact: Content, index: Int, previousButtonEnable: Bool = true, nextButtonEnabled: Bool = true) {
            self.id = animalFact.id
            self.imageLink = animalFact.image
            self.description = animalFact.fact
            self.index = index
            self.previousButtonEnable = previousButtonEnable
            self.nextButtonEnabled = nextButtonEnabled
        }
    }
    
    enum Action {
        case previousButtonTapped(Int)
        case nextButtonTapped(Int)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .previousButtonTapped(_):
                return .none
            case .nextButtonTapped(_):
                return .none
            }
        }
    }
}
