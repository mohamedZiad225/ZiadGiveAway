//
//  CategoriesViewModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import Combine
import Foundation

class CategoriesViewModel: ObservableObject {
    // MARK: - Published Properties for the View
    @Published var allGames: [HomeUIModel] = []
    @Published var groupedGames: [(platform: HomeFilterTypes, items: [HomeUIModel])] = []
    @Published var errorMessage: String?
      
      // MARK: - Private Properties
      private let categoriesUseCase: CategoriesUseCaseContract
      private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: ItemDetailsDelegate?
    
    init(categoriesUseCase: CategoriesUseCaseContract) {
        self.categoriesUseCase = categoriesUseCase
        bindUseCase()
    }
    
    // MARK: - Private Methods
    private func bindUseCase() {
            categoriesUseCase.groupedGamesSubject
                .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] groupedGames in
                    guard let self = self else {return}
                    self.groupedGames = groupedGames
                })
                .store(in: &cancellables)
        }
    
}
