//
//  MockNetworkService.swift
//  WeatherTrackerTests
//
//  Created by Chirag Anghan on 2024-12-17.
//

import XCTest
@testable import WeatherTracker

class MockNetworkService: NetworkServiceProtocol {
    var shouldThrowError = false
    var mockWeatherResponse: WeatherResponse?

    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        if shouldThrowError {
            throw CustomError.invalidURL
        }
        guard let response = mockWeatherResponse as? T else {
            throw CustomError.parsingError
        }
        return response
    }
}
