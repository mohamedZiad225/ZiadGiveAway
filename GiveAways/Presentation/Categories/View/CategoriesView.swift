//
//  CategoriesView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: CategoriesViewModel
    @State private var selectedPage = 0
    
    var body: some View {
        VStack {
            if !viewModel.groupedGames.isEmpty {
                let bannerItems = Array(viewModel.groupedGames.first?.items ??  [])
                BannerView(items: bannerItems, selectedPage: $selectedPage)
                    .frame(height: 200)
            }
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.groupedGames, id: \.platform) { group in
                        GroupedSectionView(platform: group.platform, items: group.items)
                    }
                }
                .padding()
            }
        }
    }
}
