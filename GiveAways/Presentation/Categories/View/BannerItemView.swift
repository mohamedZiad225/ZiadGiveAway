//
//  BannerItemView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct BannerItemView: View {
    let item: HomeUIModel
    
    var body: some View {
        ZStack {
            // Background Image
            if let imageUrl = item.imageURL, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 320, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } placeholder: {
                    Color.gray
                        .frame(width: 320, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            
            VStack {
                Text(item.giveAwayTitle ?? "No Title")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .padding([.leading, .trailing, .top], 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.black.opacity(0.5)
                    )
                
                Spacer()
                
                // Body text at the bottom
                Text(item.giveAwayBody ?? "No Description Available")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .padding([.leading, .trailing, .bottom], 8)
                    .background(
                        Color.black.opacity(0.7)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
