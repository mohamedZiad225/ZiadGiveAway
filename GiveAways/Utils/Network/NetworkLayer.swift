//
//  NetworkLayer.swift
//  GiveAways
//
//  Created by Mohamed Ziad on 22/01/2025.
//

import Foundation
import Moya
import Combine

public class NetworkService {
    
    private let provider: MoyaProvider<MultiTarget>
    
    public init(provider: MoyaProvider<MultiTarget> = MoyaProvider<MultiTarget>()) {
        self.provider = provider
    }
    
    public func sendRequest<ResponseType: Decodable>(target: TargetType) -> AnyPublisher<ResponseType, HTTPNetworkError> {
        return Future<ResponseType, HTTPNetworkError> { promise in
            self.provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: response.data)
                        promise(.success(decodedResponse))
                    } catch {
                        promise(.failure(.unableToDecode(error)))
                    }
                case .failure(let error):
                    promise(.failure(.other(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
