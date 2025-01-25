//
//  ContentView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var textFieldValue: String = ""
    @State private var isListVisible: Bool = true
    @State private var selectedGame: HomeUIModel?
    @StateObject var router: HomeRouter
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hello Ziad")
                                .font(.body)
                                .foregroundColor(.primary)
                            
                            Text("Explore \nGamesaways")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    TextField("Search Games by name", text: $textFieldValue)
                        .padding()
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onChange(of: textFieldValue) {
                            viewModel.searchByText(textFieldValue)
                        }
                    ScrollViewReader { scrollProxy in
                        VStack {
                            FilterButtonView(
                                filters: HomeFilterItemsUIModel().filterTypes,
                                onFilterSelected: { selectedFilter in
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        isListVisible = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        viewModel.filterGames(selectedFilter)
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            isListVisible = true
                                        }
                                    }
                                },
                                router: router
                            )
                            ScrollView {
                                LazyVStack(alignment: .center, spacing: 10) {
                                    ForEach(viewModel.homeGames, id: \.id) { game in
                                        NavigationLink(
                                            destination: ItemDetailsView(viewModel: ItemDetailsViewModel(itemDetails: itemDetailsUIMapper().transoformHomeUIModelToItemDetailsUIModel(viewModel.getGameDTO(game.itemId ?? 0), isFavourite: game.isFavourite ?? false), delegate: viewModel)),
                                            label: {
                                                GiveAwayItem(
                                                    viewModel: viewModel,
                                                    title: game.giveAwayTitle ?? "",
                                                    details: "\(game.giveAwayTitle ?? "").",
                                                    image: game.imageURL ?? "",
                                                    itemID: game.itemId ?? 0
                                                )
                                                .padding()
                                                .listRowSeparator(.hidden)
                                                .transition(.move(edge: .top))
                                            }
                                        )
                                    }
                                }
                                .opacity(isListVisible ? 1 : 0)
                            }
                            .scrollContentBackground(.hidden)
                            .navigationDestination(isPresented: $router.navigateToCategories) {
                                LazyView {
                                    router.makeCategoriesView()
                                }
                            }
                        }
                    }
                }

                // Loading Indicator
                if viewModel.isLoading {
                    Color.black.opacity(0.3) // Background dimming
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(20)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center it
                    }
                }
            }
            .navigationBarTitle("", displayMode: .automatic)
        }
    }
}







import SwiftUI

/// A view that is lazily loaded, only initialized when it appears on the screen.
struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(@ViewBuilder build: @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
