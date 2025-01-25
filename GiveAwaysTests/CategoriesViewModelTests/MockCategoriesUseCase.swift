//
//  MockCategoriesUseCase.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 25/01/2025.
//


import Combine
import Foundation

class MockCategoriesUseCase: CategoriesUseCaseContract {
    var giveAwayDto: [GiveawayDTO] = []
    var groupedGamesSubject = PassthroughSubject<[(platform: HomeFilterTypes, items: [HomeUIModel])], Error>()

    // A way to simulate the favorite functionality
    private(set) var didFavouriteItemCalls: [Int] = []

    func didFavouriteItem(_ id: Int) {
        didFavouriteItemCalls.append(id)
    }

    // Helper to emit grouped games
    func emitGroupedGames(_ groupedGames: [(platform: HomeFilterTypes, items: [HomeUIModel])]) {
        groupedGamesSubject.send(groupedGames)
    }

    // Helper to emit an error
    func emitError(_ error: Error) {
        groupedGamesSubject.send(completion: .failure(error))
    }
}
