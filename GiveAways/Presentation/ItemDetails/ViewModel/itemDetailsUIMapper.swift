//
//  itemDetailsUIMapper.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 23/01/2025.
//


struct itemDetailsUIMapper {
    func transoformHomeUIModelToItemDetailsUIModel(_ dto: GiveawayDTO, isFavourite: Bool) -> itemDetailsUIModel {
        return itemDetailsUIModel(itemId: dto.id, imageURL: dto.image,
                                  title: dto.title,
                                  body: dto.description,
                                  isFavorite: isFavourite,
                                  guideItem: transformDtoToGuidemItemsUIModel(dto),
                                  descriptionItem: getDecsriptionItems(dto))
    }
    
    func transformDtoToGuidemItemsUIModel(_ dto: GiveawayDTO) -> [GuideItemUIModel] {
        [transformDtoToGuidemItemUIModel(dto.worth, imageName: "dollarsign.circle.fill"),
         transformDtoToGuidemItemUIModel(dto.users.description, imageName: "person.circle.fill"),
         transformDtoToGuidemItemUIModel(dto.type, imageName: "arcade.stick.console.fill")]
    }
    
    func transformDtoToGuidemItemUIModel(_ title: String, imageName: String) -> GuideItemUIModel {
        return GuideItemUIModel(title: title, image: imageName)
    }
    
    func getDecsriptionItems(_ dto: GiveawayDTO) -> [DescriptionDetailsItemUIModel] {
        return[DescriptionDetailsItemUIModel(title: "Platforms", subtitle: dto.platforms),
               DescriptionDetailsItemUIModel(title: "Ends in", subtitle: dto.end_date.formatDate(from: .yyyyMMddHHmmss, to: .ddMMyyyy)),
               DescriptionDetailsItemUIModel(title: "Description", subtitle: dto.description)
        ]
    }
}