//
//  BannerView.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


import SwiftUI

struct BannerView: View {
    let items: [HomeUIModel]
    @Binding var selectedPage: Int
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(0..<items.count, id: \.self) { index in
                        GeometryReader { itemGeometry in
                            BannerItemView(item: items[index])
                                .scaleEffect(scaleForItem(at: index, geometry: itemGeometry, scrollViewWidth: geometry.size.width))
                                .opacity(opacityForItem(at: index, geometry: itemGeometry, scrollViewWidth: geometry.size.width))
                                .frame(width: 320, height: 200)
                                .onTapGesture {
                                    selectedPage = index
                                }
                        }
                        .frame(width: 320, height: 200)
                    }
                }
                .padding()
            }
        }
        .frame(height: 200)
    }
    
    private func scaleForItem(at index: Int, geometry: GeometryProxy, scrollViewWidth: CGFloat) -> CGFloat {
        let center = scrollViewWidth / 2
        let itemCenter = geometry.frame(in: .global).midX
        let distance = abs(itemCenter - center)
        
        let maxScale: CGFloat = 1.0
        let minScale: CGFloat = 0.8
        let scaleRange = maxScale - minScale
        
        return max(minScale, maxScale - (distance / center) * scaleRange)
    }
    
    private func opacityForItem(at index: Int, geometry: GeometryProxy, scrollViewWidth: CGFloat) -> Double {
        let center = scrollViewWidth / 2
        let itemCenter = geometry.frame(in: .global).midX
        let distance = abs(itemCenter - center)
        
        let maxOpacity: Double = 1.0
        let minOpacity: Double = 0.5
        let opacityRange = maxOpacity - minOpacity
        
        return max(minOpacity, maxOpacity - (distance / center) * opacityRange)
    }
}
