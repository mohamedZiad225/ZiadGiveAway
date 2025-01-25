//
//  HomeUIModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation

public struct HomeUIModel: Identifiable {
    public let id = UUID()
    public var itemId: Int?
    public var giveAwayTitle: String?
    public var giveAwayBody: String?
    public var imageURL: String?
    public var platforms: [HomeFilterTypes]?
    public var isFavourite: Bool?
    
    public init(itemId: Int? = nil, giveAwayTitle: String? = nil, giveAwayBody: String? = nil, imageURL: String? = nil, platforms: [HomeFilterTypes]? = [], isFavourite: Bool? = nil) {
        self.itemId = itemId
        self.giveAwayTitle = giveAwayTitle
        self.giveAwayBody = giveAwayBody
        self.imageURL = imageURL
        self.platforms = platforms
        self.isFavourite = isFavourite
    }
}



