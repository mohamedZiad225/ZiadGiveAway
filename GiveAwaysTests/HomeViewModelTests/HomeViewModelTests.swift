//
//  HomeViewModelTests.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 24/01/2025.

import XCTest
import Combine
@testable import GiveAways

class HomeViewModelTests: XCTestCase {
    var mockUseCase: MockHomeUseCase!
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockHomeUseCase()
        viewModel = HomeViewModel(homeUseCase: mockUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    
    func testFilterByPlatform() {
        // Given: Mock data
        let allGames = [
            HomeUIModel(itemId: 1, giveAwayTitle: "Game 1", platforms: [HomeFilterTypes.pc]),
            HomeUIModel(itemId: 2, giveAwayTitle: "Game 2", platforms: [HomeFilterTypes.steam]),
            HomeUIModel(itemId: 3, giveAwayTitle: "Game 3", platforms: [HomeFilterTypes.pc])
        ]
        mockUseCase.currentGames = allGames
        let expectation = XCTestExpectation(description: "Games are filtered by platform")
        
        viewModel.$homeGames
            .dropFirst()
            .sink { games in
                // Then: Expecting only "pc" platform games
                XCTAssertEqual(games.count, 2)
                XCTAssertTrue(games.allSatisfy { $0.platforms?.contains(HomeFilterTypes(rawValue: HomeFilterTypes.pc.rawValue) ?? .all) == true })
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.filterGames(.pc)
        
        wait(for: [expectation], timeout: 1.0)
    }
   
    
    
    func testSearchByText() {
        // Given: Mock data
        let allGames = [
            HomeUIModel(itemId: 1, giveAwayTitle: "Game 1"),
            HomeUIModel(itemId: 2, giveAwayTitle: "Game 2"),
            HomeUIModel(itemId: 3, giveAwayTitle: "Another one")
        ]
        mockUseCase.currentGames =  allGames
        let expectation = XCTestExpectation(description: "Filtered games are emitted")
        
        viewModel.$homeGames
            .dropFirst()
            .sink { games in
                if games.count == 2 {
                    XCTAssertTrue(games.contains(where: { $0.giveAwayTitle == "Game 1" }))
                    XCTAssertTrue(games.contains(where: { $0.giveAwayTitle == "Game 2" }))
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.searchByText("Game")
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDidFavourite() {
        // Given: Mock data
        let allGames = [
            HomeUIModel(itemId: 1, giveAwayTitle: "Game 1", isFavourite: false),
            HomeUIModel(itemId: 2, giveAwayTitle: "Game 2", isFavourite: false)
        ]
        mockUseCase.currentGames =  allGames
        mockUseCase.gamesSubject.send(allGames)
        let expectation = XCTestExpectation(description: "Favorite status is toggled")
        
        // When: Subscribing to `homeGames` and toggling favorite
        viewModel.$homeGames
            .sink { games in
                let updatedGame = games.first { $0.itemId == 1 }
                if updatedGame?.isFavourite == true {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.didFavourite(1)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadingState() {
        // Given: Initial state
        XCTAssertFalse(viewModel.isLoading)
        
        let expectation = XCTestExpectation(description: "Loading state is updated")
        viewModel.$isLoading
            .sink { isLoading in
                if isLoading == true {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        mockUseCase.loading.send(true)
        
        // Then: Wait for expectation
        wait(for: [expectation], timeout: 1.0)
    }
}
