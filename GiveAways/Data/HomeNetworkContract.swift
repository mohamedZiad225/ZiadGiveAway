//
//  HomeNetworkContract.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Combine

protocol HomeRepositoryProtocol {
    func getGames() -> AnyPublisher<[GiveawayDTO], HTTPNetworkError>
    func getFilteredGames(platform: String) -> AnyPublisher<[GiveawayDTO], HTTPNetworkError>
}

