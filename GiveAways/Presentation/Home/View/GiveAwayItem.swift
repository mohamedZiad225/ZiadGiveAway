//
//  GiveAwayItem.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import SwiftUI

struct GiveAwayItem: View {
    @StateObject var viewModel: HomeViewModel
    internal var itemWidth = UIScreen.main.bounds.width - 30
    var title: String
    var details: String
    var image: String
    var itemID: Int

    
    var body: some View {
        ZStack(alignment: .top) {
            AsyncImage(url: URL(string: image)) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.5)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                case .success(let image):
                    image
                        .resizable()
                                      .scaledToFill()
                                      .frame(width: itemWidth, height: 300)
                                      .clipShape(RoundedRectangle(cornerRadius: 15))
                                      .overlay(
                                          Color.black.opacity(0.5)
                                              .clipShape(RoundedRectangle(cornerRadius: 15))
                                      )
                case .failure:
                    Color.white.opacity(0.5)
                        .frame(width: itemWidth, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            Color.black.opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        )
                @unknown default:
                    Color.white.opacity(0.5)
                        .frame(width: itemWidth, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            Color.black.opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        )
                }
            }
            
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 15)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.didFavourite(itemID)
                    }) {
                        Image(systemName: (viewModel.homeGames.first { $0.itemId == itemID }?.isFavourite ?? false) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor((viewModel.homeGames.first { $0.itemId == itemID }?.isFavourite ?? false) ? .red : .white)
                            .padding(.trailing, 15)
                            .padding(.top, 10)
                    }
                }
                Spacer()
                
                Text(details)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.trailing, 15)
                    .padding(.bottom, 10)
                    .padding(.leading, 5)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding() // Padding around the entire item
    }
}



