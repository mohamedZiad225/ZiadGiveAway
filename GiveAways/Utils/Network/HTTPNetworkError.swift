//
//  HTTPNetworkError.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//


import Foundation

public enum HTTPNetworkError: Error {
    case noData
    case unableToDecode(Error)
    case other(String)
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data received from server."
        case .unableToDecode(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .other(let description):
            return description
        }
    }
}
