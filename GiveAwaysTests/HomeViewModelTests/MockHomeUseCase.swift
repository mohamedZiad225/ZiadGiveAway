//
//  MockHomeUseCase.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.

import Combine
import Foundation

class MockHomeUseCase: HomeUseCaseContract {
    var giveAwayDto: [GiveawayDTO] = []
    var gamesSubject = PassthroughSubject<[HomeUIModel], Error>()
    var loading = CurrentValueSubject<Bool, Never>(false)
    var currentGames: [HomeUIModel] = []
    
    
    private(set) var didFavouriteItemCalls: [Int] = []
    private(set) var searchGamesCalls: [String] = []
    
    func getFilterItems(_ filterBy: HomeFilterTypes) {
        switch filterBy {
        case .all, .more:
            gamesSubject.send(currentGames)
        default:
            let filteredGames = currentGames.filter { game in
                game.platforms?.contains(HomeFilterTypes(rawValue: filterBy.rawValue) ?? .all) == true
            }
            gamesSubject.send(filteredGames)
        }
    }
    func getSelectedItemDto(_ id: Int) -> GiveawayDTO {
        return giveAwayDto.first { $0.id == id } ?? GiveawayDTO(id: 1, title: "", description: "", image: "", worth: "", platforms: "", users: 0, type: "", status: "", end_date: "")    }
    
    func didFavouriteItem(_ id: Int) {
        didFavouriteItemCalls.append(id)
        guard  let index = currentGames.firstIndex(where: {$0.itemId  == id }) else {return}
        currentGames[index].isFavourite = !(currentGames[index].isFavourite ?? false)
        gamesSubject.send(currentGames)
    }
    
    func searchGames(query: String) {
        searchGamesCalls.append(query)
        let filteredGames = currentGames.filter {
            $0.giveAwayTitle?.contains(query) == true
        }
        gamesSubject.send(filteredGames)
    }
}
