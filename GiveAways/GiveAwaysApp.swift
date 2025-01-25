//
//  GiveAwaysApp.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import SwiftUI

@main
struct GiveAwaysApp: App {
    @StateObject private var router = HomeRouter(repository: Repository(networkService: NetworkService()))
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeViewModel(homeUseCase: HomeUseCase(repository: Repository(networkService: NetworkService()))),
                router: router
            )
        }
    }
}
