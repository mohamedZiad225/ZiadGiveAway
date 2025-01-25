//
//  HomeViewModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.

import Foundation
import Combine

public class HomeViewModel: ObservableObject {
    // MARK: - Published Properties for the View
    @Published public var homeGames: [HomeUIModel] = []
    @Published public var isLoading: Bool = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let homeUseCase: HomeUseCaseContract
    
    public init(homeUseCase: HomeUseCaseContract) {
        self.homeUseCase = homeUseCase
        subscribeToLoadingState()
        subscribeToGames()
    }
    
    
    func filterGames(_ filterBy: HomeFilterTypes) {
        homeUseCase.getFilterItems(filterBy)
    }
    
    func getGameDTO(_ itemId: Int) -> GiveawayDTO {
        return homeUseCase.getSelectedItemDto(itemId)
    }
    
    func didFavourite(_ itemId: Int) {
        homeUseCase.didFavouriteItem(itemId)
    }
    
    func searchByText(_ text: String) {
        homeUseCase.searchGames(query: text)
    }
    
    private func subscribeToLoadingState() {
        homeUseCase.loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else {return}
                self.isLoading = isLoading
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToGames() {
        homeUseCase.gamesSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching games: \(error)")
                }
            }, receiveValue: { [weak self] uiModels in
                guard let self = self else {return}
                self.isLoading = false
                self.homeGames = uiModels
            })
            .store(in: &cancellables)
    }
}


extension HomeViewModel: ItemDetailsDelegate {
    func didToggleFavorite(for itemId: Int) {
        homeUseCase.didFavouriteItem(itemId)
    }
}
