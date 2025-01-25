//
//  NetworkLayer.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Alamofire
import Combine

public class NetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func sendRequest<ResponseType: Decodable>(request: URLRequest) -> AnyPublisher<ResponseType, HTTPNetworkError> {
        return session.dataTaskPublisher(for: request)
            .map { $0.data } // Extract the data from the response
            .decode(type: ResponseType.self, decoder: JSONDecoder()) // Decode the data into the ResponseType
            .mapError { error in
                // Map any errors to HTTPNetworkError
                error as? HTTPNetworkError ?? .other(error.localizedDescription)
            }
            .eraseToAnyPublisher() // Erase the publisher type to make it simpler to use
    }
}
