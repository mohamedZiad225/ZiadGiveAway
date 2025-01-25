//
//  ItemDetailsView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import SwiftUI

struct ItemDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ItemDetailsViewModel
    @State private var isFavorited: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.itemDetails?.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .frame(width: UIScreen.main.bounds.width - 30)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    Color.black.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                )
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.leading, 30)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: (viewModel.itemDetails?.isFavorite ?? false) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(viewModel.itemDetails?.isFavorite ?? false ? .red : .white)
                            .padding(.trailing, 15)
                            .padding(.top, 10)
                    }                    .padding()
                }
            }
            HStack(spacing: 40) {
                ItemGuideView(guides: viewModel.itemDetails?.guideItem ?? [])
            }
            
            DescriptionItemView(guides: viewModel.itemDetails?.descriptionItem ?? [])
            
                .padding(.top, 16)
            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
