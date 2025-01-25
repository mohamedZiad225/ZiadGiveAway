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
// MARK: - HomeNetworkContract

extension Repository: HomeRepositoryProtocol {
    func getFilteredGames(platform: String) -> AnyPublisher<[GiveawayDTO], HTTPNetworkError> {
        networkService.sendRequest(request: URLRequestBuilder.build(baseUrl: "https://www.gamerpower.com", path: "/api/giveaways", parameters: ["platform": platform]))
    }
    
    func getGames() -> AnyPublisher<[GiveawayDTO], HTTPNetworkError> {
        networkService.sendRequest(request: URLRequestBuilder.build(baseUrl: "https://www.gamerpower.com", path: "/api/giveaways"))
    }
}
