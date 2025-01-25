
//  CategoriesUseCase.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


import Foundation
import Combine

class CategoriesUseCase: CategoriesUseCaseContract {
    
    private var allGames: [HomeUIModel] = []
    private var cancellables = Set<AnyCancellable>()
    private let repository: HomeRepositoryProtocol
    public var giveAwayDto: [GiveawayDTO] = []
    
    public var groupedGamesSubject = PassthroughSubject<[(platform: HomeFilterTypes, items: [HomeUIModel])], Error>()
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
        fetchGiveaways()
    }
    
    private func fetchGiveaways() {
        repository.getGames()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.groupedGamesSubject.send(completion: .failure(error))
                }
            }, receiveValue: { [weak self] dto in
                guard let self = self else { return }
                let groupedData = CategoriesUIMapper().transformDtoToGiveAway(dto)
                groupedGamesSubject.send(groupedData)
            })
            .store(in: &cancellables)
    }
    
    
    func didFavouriteItem(_ id: Int) {
        guard let index = allGames.firstIndex(where: { $0.itemId == id }) else { return }
        allGames[index].isFavourite = !(allGames[index].isFavourite ?? false)
    }
}
