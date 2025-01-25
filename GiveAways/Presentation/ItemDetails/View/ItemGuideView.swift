//
//  ItemGuideView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct ItemGuideView: View {
    var guides: [GuideItemUIModel]
    
    var body: some View {
        VStack {
            HStack(spacing: 40) {
                ForEach(guides, id: \.id) { guide in
                    VStack(spacing: 5) {
                        Image(systemName: guide.image ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                        Text(guide.title ?? "")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
        }
    }
}


#Preview {
    let sampleGuides = [
        GuideItemUIModel(title: "N/A", image: "Valid Until"),
        GuideItemUIModel(title: "1980", image: "Limited Offer"),
        GuideItemUIModel(title: "Early Access", image: "Popular")
    ]
    ItemGuideView(guides: sampleGuides)
}
