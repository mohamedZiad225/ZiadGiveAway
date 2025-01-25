//
//  CategoriesUIMapper.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


import Foundation

public struct CategoriesUIMapper {
    
    func transformDtoToGiveAway(_ model: [GiveawayDTO]) -> [(platform: HomeFilterTypes, items: [HomeUIModel])] {
        var homeUIModel = [HomeUIModel]()
        for dto in model {
            let platformTypes = splitPlatForms(platForms: dto.platforms)
            var uiModel = HomeUIModel(platforms: platformTypes)
            uiModel.itemId =  dto.id
            uiModel.giveAwayTitle = dto.title
            uiModel.giveAwayBody = dto.description
            uiModel.imageURL = dto.image
            uiModel.isFavourite = false
            homeUIModel.append(uiModel)
        }
        let sectionedData = groupItemsByPlatform(items: homeUIModel)
        return sectionedData
    }
    
    private func groupItemsByPlatform(items: [HomeUIModel]) -> [(platform: HomeFilterTypes, items: [HomeUIModel])] {
        var groupedItems = [HomeFilterTypes: [HomeUIModel]]()
        
        for item in items {
            let platforms = item.platforms ?? []
            for platform in platforms {
                if groupedItems[platform] == nil {
                    groupedItems[platform] = []
                }
                groupedItems[platform]?.append(item)
            }
        }
        let sectionedData = groupedItems.map { (platform, items) in
            return (platform, items)
        }
        return sectionedData
    }
    
    private func splitPlatForms(platForms: String) -> [HomeFilterTypes] {
        let platforms = platForms.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        return platforms.compactMap { platform in
            return HomeFilterTypes(rawValue: platform.lowercased())
        }
    }
}
