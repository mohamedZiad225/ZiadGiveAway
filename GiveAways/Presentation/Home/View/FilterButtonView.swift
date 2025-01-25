//
//  FilterButtonView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//
import SwiftUI

struct FilterButtonView: View {
    var filters: [HomeFilterTypes]
    var onFilterSelected: (HomeFilterTypes) -> Void
    @ObservedObject var router: HomeRouter
    @State private var selectedFilter: HomeFilterTypes? = .all

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(filters, id: \.self) { filter in
                    Button(action: {
                        handleFilterSelection(filter)
                    }) {
                        Text(filter.rawValue)
                            .padding()
                            .foregroundColor(selectedFilter == filter ? .black : .blue)
                            .background(selectedFilter == filter ? Color.gray.opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func handleFilterSelection(_ filter: HomeFilterTypes) {
        selectedFilter = filter
        if filter == .more {
            router.navigateToCategories = true
        } else {
            onFilterSelected(filter)
        }
    }
}
