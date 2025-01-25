//
//  itemDetailsUIModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//

import Foundation

struct itemDetailsUIModel: Identifiable {
    let id = UUID()
    let itemId: Int
    let imageURL: String?
    let title:String?
    let body: String?
    var isFavorite: Bool?
    let guideItem: [GuideItemUIModel]?
    let descriptionItem: [DescriptionDetailsItemUIModel]
}
    
