//
//  NetworkService.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import Foundation

enum CustomError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case cityNotFound
    case noInternetConnection
    case unknownError
    case parsingError
    case apiError(String)
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid. Please check the URL and try again."
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .cityNotFound:
            return "The specified city could not be found. Please try searching again."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings and try again."
        case .unknownError:
            return "An unknown error occurred. Please try again."
        case .apiError(let message):
            return "API error: \(message)"
        case .parsingError:
            return "Parsing error occurred. Please check your response and try again."
        }
    }
}


protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(T.self, from: data)
    }
}
