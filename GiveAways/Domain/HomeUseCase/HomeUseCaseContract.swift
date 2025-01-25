//
//  HomeUseCaseContract.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Combine

public protocol HomeUseCaseContract {
    func getFilterItems(_ filterBy: HomeFilterTypes)
    func getSelectedItemDto(_ id: Int) -> GiveawayDTO
    func didFavouriteItem(_ id: Int)
    func searchGames(query: String)
    var giveAwayDto: [GiveawayDTO] { get }
    var gamesSubject: PassthroughSubject<[HomeUIModel], Error> { get }
    var loading: CurrentValueSubject<Bool, Never> { get }

}
