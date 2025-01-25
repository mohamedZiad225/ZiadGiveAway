//
//  GiveawayAPI.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 25/01/2025.
//


import Moya
import Foundation

enum GiveawayAPI {
    case getFilteredGames(platform: String)
    case getGames
}

extension GiveawayAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.gamerpower.com")!
    }
    
    var path: String {
        switch self {
        case .getFilteredGames, .getGames:
            return "/api/giveaways"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getFilteredGames(let platform):
            return .requestParameters(parameters: ["platform": platform], encoding: URLEncoding.queryString)
        case .getGames:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
