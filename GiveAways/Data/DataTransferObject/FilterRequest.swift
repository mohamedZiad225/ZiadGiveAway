//
//  FilterRequestBuilder.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 24/01/2025.
//

import Foundation


public struct FilterRequest: Codable {
    let platform: String?
    
    public init(platform: String?) {
        self.platform = platform
    }
}
