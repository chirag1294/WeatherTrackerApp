//
//  WeatherViewModelTests.swift
//  WeatherTrackerTests
//
//  Created by Chirag Anghan on 2024-12-17.
//

import XCTest
@testable import WeatherTracker

final class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = WeatherViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        UserDefaults.standard.removeObject(forKey: "SavedCity")
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() async {
        
        let mockResponse = WeatherResponse(
            location: WeatherResponse.Location(name: "Mumbai"),
            current: WeatherResponse.Current(
                tempC: 20.0,
                condition: WeatherResponse.Current.Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"),
                humidity: 60,
                uv: 5.0,
                feelslikeC: 21.0
            )
        )
        mockNetworkService.mockWeatherResponse = mockResponse
        
        
        await viewModel.fetchWeather(for: "Mumbai")
        
        
        XCTAssertNotNil(viewModel.weather, "Weather data should not be nil")
        XCTAssertEqual(viewModel.weather?.cityName, "Mumbai", "City name should match")
        XCTAssertEqual(viewModel.weather?.temperature, 20.0, "Temperature should match")
    }
    
    func testFetchWeatherWithInvalidURL() async {
        mockNetworkService.shouldThrowError = true
        
        await viewModel.fetchWeather(for: "")
        
        XCTAssertNil(viewModel.weather, "Weather data should be nil for invalid URL")
    }
    
    func testFetchWeatherNetworkFailure() async {
        mockNetworkService.shouldThrowError = true
        
        await viewModel.fetchWeather(for: "InvalidCity")
        
        XCTAssertNil(viewModel.weather, "Weather data should be nil on network failure")
    }
    
    func testLoadSavedCity() async {

        UserDefaults.standard.set("London", forKey: "SavedCity")
        let mockResponse = WeatherResponse(
            location: WeatherResponse.Location(name: "London"),
            current: WeatherResponse.Current(
                tempC: 10.0,
                condition: WeatherResponse.Current.Condition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"),
                humidity: 50,
                uv: 5.0,
                feelslikeC: 15.0
            )
        )
        mockNetworkService.mockWeatherResponse = mockResponse
        
        await viewModel.loadSavedCity()
        
        XCTAssertNotNil(viewModel.weather, "Weather data should not be nil")
        XCTAssertEqual(viewModel.weather?.cityName, "London", "City name should match saved city")
        XCTAssertEqual(viewModel.weather?.temperature, 10.0, "Temperature should match")
    }
}
