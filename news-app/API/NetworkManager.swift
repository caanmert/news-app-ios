//
//  NetworkManager.swift
//  news-app
//
//  Created by jaerka on 15.04.23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case apiError(String)
    case unknown
}

protocol NetworkProtocol {
    func fetchData<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, NetworkError>
    func cancel()
}

class NetworkManager: NetworkProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.apiError("Please check your internet connection and try again")
                case is DecodingError:
                    return NetworkError.decodingError
                case let apiError as NetworkError:
                    return apiError
                default:
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

