//
//  HomeRouter.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import Combine
import SwiftUI

class HomeRouter: ObservableObject {
    @Published var navigateToCategories: Bool = false
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    func makeCategoriesView() -> some View {
        let useCase = CategoriesUseCase(repository: repository)
        let viewModel = CategoriesViewModel(categoriesUseCase: useCase)
        return CategoriesView(viewModel: viewModel)
    }
}
