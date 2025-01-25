//
//  HomeUIMapper.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation

public struct HomeUIMapper {
    
    func transfromDtoToGiveAway(_ model: [GiveawayDTO]) -> [HomeUIModel] {
        var homeUIModel = [HomeUIModel]()
        for dto in model {
            var platformTypes = [HomeFilterTypes]()
            var uiModel = HomeUIModel(platforms: platformTypes)
            uiModel.itemId =  dto.id
            uiModel.giveAwayTitle = dto.title
            uiModel.giveAwayBody = dto.description
            uiModel.imageURL = dto.image
            platformTypes = splitPlatForms(platForms: dto.platforms)
            uiModel.platforms = platformTypes
            uiModel.isFavourite = false
            homeUIModel.append(uiModel)
        }
        return homeUIModel
    }
    
    private func splitPlatForms(platForms: String) -> [HomeFilterTypes] {
        let platforms = platForms.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        return platforms.compactMap { platform in
            return HomeFilterTypes(rawValue: platform.lowercased())
        }
    }
}
