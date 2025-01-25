//
//  HomeUseCase.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Combine

class HomeUseCase: HomeUseCaseContract {

    private var allGames: [HomeUIModel] = []
    private var cancellables = Set<AnyCancellable>()
    private let repository: HomeRepositoryProtocol
    var giveAwayDto: [GiveawayDTO] = []
    var gamesSubject = PassthroughSubject<[HomeUIModel], Error>()
    var loading = CurrentValueSubject<Bool, Never>(false)
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
        getGiveAways()
    }
    
    private func getGiveAways() {
        loading.send(true)
        repository.getGames()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.gamesSubject.send(completion: .failure(error))
                }
            }, receiveValue: { [weak self] model in
                guard let self = self else {return}
                self.loading.send(false)
                self.giveAwayDto = model
                self.allGames = HomeUIMapper().transfromDtoToGiveAway(model)
                self.gamesSubject.send(allGames)
            })
            .store(in: &cancellables)
    }
    
    func getFilterItems(_ filterBy: HomeFilterTypes) {
        switch  filterBy {
        case .all, .more:
            gamesSubject.send(allGames)
        default:
            fetchFilteredGames(platform: filterBy.rawValue)
        }
    }
    
    private func fetchFilteredGames(platform: String) {
        loading.send(true)
        self.gamesSubject.send([])
        repository.getFilteredGames(platform: HomeFilterTypes(rawValue: platform)?.queryParameter ?? "")
               .sink(receiveCompletion: { [weak self] completion in
                   guard let self = self else {return}
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       self.gamesSubject.send(completion: .failure(error))
                   }
               }, receiveValue: { [weak self] filteredGames in
                   guard let self = self else {return}
                   loading.send(false)
                   self.gamesSubject.send(HomeUIMapper().transfromDtoToGiveAway(filteredGames))
               })
               .store(in: &cancellables)
       }

    func getSelectedItemDto(_ id: Int) -> GiveawayDTO {
        return giveAwayDto.first(where: { $0.id == id }) ?? GiveawayDTO(id: 0, title: "", description: "", image: "", worth: "", platforms: "", users: 0, type: "", status: "", end_date: "20-10-2026")
    }
    
    func didFavouriteItem(_ id: Int) {
        guard let index = allGames.firstIndex(where: { $0.itemId == id }) else { return }
        allGames[index].isFavourite = !(allGames[index].isFavourite ?? false)
        gamesSubject.send(allGames)
    }
    
    func searchGames(query: String) {
        if query.isEmpty {
            gamesSubject.send(allGames)
            return
        }
        
        let lowercasedQuery = query.lowercased()
        let filteredGames = allGames.filter { game in
            game.giveAwayTitle?.lowercased().contains(lowercasedQuery) == true ||
            game.giveAwayBody?.lowercased().contains(lowercasedQuery) == true
        }
        gamesSubject.send(filteredGames)
    }
}

