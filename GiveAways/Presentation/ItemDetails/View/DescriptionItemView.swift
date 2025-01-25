//
//  DescriptionItemView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import SwiftUI

struct DescriptionItemView: View {
    var guides: [DescriptionDetailsItemUIModel]
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(guides, id: \.id) { guide in
                VStack(alignment: .leading, spacing: 2) {
                    Text(guide.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text(guide.subtitle)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    DescriptionItemView(guides: [])
}

