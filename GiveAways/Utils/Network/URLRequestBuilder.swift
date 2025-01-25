//
//  URLRequestBuilder.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//


import Foundation

import Foundation

public struct URLRequestBuilder {
    
    public static func build(baseUrl: String, path: String, method: HTTPMethod = .get, headers: [String: String] = [:], parameters: [String: String] = [:],body: Encodable? = nil)-> URLRequest {
        // Construct the full URL
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = path
        
        // Add query parameters
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Set headers
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set body if provided
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        return request
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
