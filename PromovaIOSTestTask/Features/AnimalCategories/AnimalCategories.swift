//
//  AnimalCategories.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 28/7/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct AnimalCategories {
    
    @ObservableState
    struct State {
        
        var categories: IdentifiedArrayOf<AnimalFact> = []
        var isLoading: Bool = false
        var adShowed: Bool = false
        var selectedCategory = StackState<Info.State>()
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        
        case fetchAnimals
        case categoriesResponse(TaskResult<AnimalFacts>)
        case categorieTapped(UUID)
        case navigationSelectionSet(UUID)
        case watchAdTapped(UUID)
        case adDismissed(UUID)
        case adWatched
        case alert(PresentationAction<Alert>)
        case info(StackActionOf<Info>)
        
        enum Alert {
            case alertDismissed
            case watchAdTapped(UUID)
            case fetchAnimals
        }
    }
    
    @Reducer
    enum Info {
        case animalInfo(AnimalInfo)
    }
    
    @Dependency(\.apiClient) var apiClient: ApiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .fetchAnimals:
                state.isLoading = true
                return .run { send in
                    await send(.categoriesResponse(TaskResult { try await apiClient.fetchAnimals() }))
                }
                
            case let .categoriesResponse(response):
                
                switch response {
                case let .success(categories):
                    state.isLoading = false
                    state.categories = IdentifiedArray(uniqueElements: categories.sorted {  $0.order < $1.order })
                case let .failure(error):
                    state.isLoading = false
                    state.alert = AlertState(title: {
                        TextState("Ooops")
                    }, actions: {
                        ButtonState(action: .fetchAnimals) {
                            TextState("Try again")
                        }
                        ButtonState(action: .alertDismissed) {
                            TextState("Next time")
                        }
                    }, message: {
                        TextState("Something went wrong: \(error.localizedDescription).")
                    })
                }
                
                return .none
                
            case let .categorieTapped(categoryId):
                
                guard let category = state.categories.first(where: { $0.id == categoryId }) else {
                    return .none
                }
                switch category.status {
                    
                case .free:
                    return .send(.navigationSelectionSet(categoryId))
                case .paid:
                    
                    state.alert = AlertState(
                        title: {
                            TextState("Watch Ad to continue")
                        }, actions: {
                            ButtonState(action: .watchAdTapped(categoryId)) {
                                TextState("Show Ad")
                            }
                            ButtonState(action: .alertDismissed) {
                                TextState("Cancel")
                            }
                        }
                    )
                    return .none
                    
                case .comingSoon:
                    
                    state.alert = AlertState(
                        title: {
                        TextState("Coming Soon ...")
                        }, actions: {
                            ButtonState(action: .alertDismissed) {
                                TextState("OK")
                            }
                        }, message: {
                            TextState("We are working to ensure that you can see content about \(category.title). We need a little more time, sorry.")
                        })
                    
                    return .none
                }
                
            case let .navigationSelectionSet(id):
                guard let category = state.categories.first(where: { $0.id == id }) else { return .none }
                state.selectedCategory.append(.animalInfo(AnimalInfo.State(animalFact: category)))
                return .none
            case let .watchAdTapped(categoryId):
                
                state.adShowed = true
                return .run { send in
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    await send(.adDismissed(categoryId))
                }
                
            case let .adDismissed(categoryId):
                state.adShowed = false
                return .run { send in
                    await send(.navigationSelectionSet(categoryId))
                }
                
            case .adWatched:
                return .none
                
            case let .alert(alertActions):
                switch alertActions {
                    
                case .dismiss:
                    return .none
                case .presented(.alertDismissed):
                    
                    state.alert = nil
                    return .none
                    
                case .presented(.fetchAnimals):
                    
                    state.isLoading = true
                    return .run { send in
                        await send(.categoriesResponse(TaskResult { try await apiClient.fetchAnimals() }))
                    }
                    
                case let .presented(.watchAdTapped(categoryId)):
                    state.adShowed = true
                    return .run { send in
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        await send(.adDismissed(categoryId))
                    }
                }
            case .info(_):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.selectedCategory, action: \.info)
    }
}
