//
//  HomeRepository.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Combine



class Repository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - HomeRepositoryProtocol
extension Repository: HomeRepositoryProtocol {
    func getFilteredGames(platform: String) -> AnyPublisher<[GiveawayDTO], HTTPNetworkError> {
        return networkService.sendRequest(target: GiveawayAPI.getFilteredGames(platform: platform))
    }
    
    func getGames() -> AnyPublisher<[GiveawayDTO], HTTPNetworkError> {
        return networkService.sendRequest(target: GiveawayAPI.getGames)
    }
}
