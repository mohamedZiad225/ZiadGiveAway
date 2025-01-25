//
//  HomeFilterItemsUIModel.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation

public struct HomeFilterItemsUIModel {
    var  filterTypes: [HomeFilterTypes] = HomeFilterTypes.allCases
}


public enum HomeFilterTypes: String, CaseIterable {
    case all = "All"
    case pc = "pc"
    case steam = "steam"
    case epic = "epic games store"
    case playstation4 = "playstation 4"
    case iOS = "ios"
    case android = "android"
    case more = "More"
    
    var queryParameter: String {
           switch self {
           case .all:
               return ""
           case .pc:
               return "pc"
           case .steam:
               return "steam"
           case .epic:
               return "epic-games-store"
           case .playstation4:
               return "ps4"
           case .iOS:
               return "ios"
           case .android:
               return "android"
           case .more:
               return "more"
           }
       }

}

