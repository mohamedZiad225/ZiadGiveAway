//
//  CategoriesUseCaseContract.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


import Foundation
import Combine

public protocol CategoriesUseCaseContract {
    func didFavouriteItem(_ id: Int)
    var giveAwayDto: [GiveawayDTO] { get }
    var groupedGamesSubject: PassthroughSubject<[(platform: HomeFilterTypes, items: [HomeUIModel])], Error> { get }
}
