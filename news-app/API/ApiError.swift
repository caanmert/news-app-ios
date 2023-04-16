//
//  ApiError.swift
//  news-app
//
//  Created by jaerka on 16.04.23.
//

import Foundation


enum APIError: Error {
    case decodingError(Error)
    case noInternetConnection
    case connectionLost
    case invalidStatusCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .noInternetConnection:
            return "No internet connection"
        case .connectionLost:
            return "Connection lost"
        case .invalidStatusCode(let statusCode):
            return  "Invalid status code: \(statusCode)"
        }
    }
}
