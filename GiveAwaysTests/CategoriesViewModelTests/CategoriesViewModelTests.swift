//
//  CategoriesViewModelTest.swift
//  GiveAwaysTests
//
//  Created by Mohamed Ziad on 25/01/2025.
//

import XCTest
import Combine
@testable import GiveAways

class CategoriesViewModelTests: XCTestCase {
    var mockUseCase: MockCategoriesUseCase!
    var viewModel: CategoriesViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockCategoriesUseCase()
        viewModel = CategoriesViewModel(categoriesUseCase: mockUseCase)
        cancellables = []
    }

    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testGroupedGamesEmission() {
        // Given: Mock data
        let groupedGames: [(platform: HomeFilterTypes, items: [HomeUIModel])] = [
            (.pc, [HomeUIModel(itemId: 1, giveAwayTitle: "Game 1")]),
            (.playstation4, [HomeUIModel(itemId: 2, giveAwayTitle: "Game 2")])
        ]

        let expectation = XCTestExpectation(description: "Grouped games are emitted and received")
        viewModel.$groupedGames
            .dropFirst() 
            .sink { grouped in
                XCTAssertEqual(grouped.count, 2)
                XCTAssertEqual(grouped[0].platform, .pc)
                XCTAssertEqual(grouped[1].platform, .playstation4)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockUseCase.emitGroupedGames(groupedGames)

        // Then: Wait for expectation
        wait(for: [expectation], timeout: 1.0)
    }

    func testErrorEmission() {
        // Given: Mock error
        let mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        let expectation = XCTestExpectation(description: "Error is emitted and handled")

        // When: Subscribing to `errorMessage` and emitting an error
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, mockError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockUseCase.emitError(mockError)

        // Then: Wait for expectation
        wait(for: [expectation], timeout: 1.0)
    }

    func testDidFavouriteItem() {
        let itemId = 1
        mockUseCase.didFavouriteItem(itemId)
        XCTAssertTrue(mockUseCase.didFavouriteItemCalls.contains(itemId))
    }
}

