//
//  GroupedSectionView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct GroupedSectionView: View {
    let platform: HomeFilterTypes
    let items: [HomeUIModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(platform.rawValue.capitalized)
                .font(.headline)
                .padding(.bottom, 4)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 3), spacing: 5) {
                ForEach(items, id: \.id) { item in
                    GameItemView(game: item)
                        .frame(width: 120)
                        .padding(5)
                }
            }
        }
        .padding(.bottom, 16)
    }
}

