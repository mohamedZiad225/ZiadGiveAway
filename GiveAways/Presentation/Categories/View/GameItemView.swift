//
//  GameItemView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct GameItemView: View {
    let game: HomeUIModel
    @State private var isFavourite: Bool = false
    
    var body: some View {
        ZStack {
            if let imageUrl = game.imageURL, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            Color.black.opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        )
                } placeholder: {
                    Color.gray
                        .frame(width: 120, height: 150)
                }
                .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(game.giveAwayTitle ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .padding(.top, 22)
                    .padding(.horizontal, 15)
                
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isFavourite.toggle()
                    }) {
                        Image(systemName: (isFavourite ? "heart.fill" : "heart"))
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(isFavourite ? .red : .white)
                            .padding(.trailing, 2)
                            .padding(.bottom, 15)
                    }
                    .contentShape(Rectangle())
                    .frame(width: 40, height: 40)
                }
            }
            .padding(.horizontal, -4)
        }
        .cornerRadius(15)
        .padding(.horizontal, 5)
        .frame(height: 180)
        .onTapGesture {
            isFavourite.toggle()
        }
        .contentShape(Rectangle()) 
    }
}


            
           

