//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchWeather(for cityName: String) async {
        do {
            let urlString = Constants.API.weatherURL + Constants.API.key + "&q=" + cityName
            let url = URL(string: urlString)
            guard let url else {
                throw CustomError.invalidURL
            }
            let response: WeatherResponse = try await networkService.fetchData(from: url)
            self.weather = Weather(from: response)
            self.saveCity(cityName: response.location.name)
        } catch {
            self.weather = nil
            print("Error fetching weather: \(error.localizedDescription)")
        }
    }

    func loadSavedCity() async {
        if let savedCity = UserDefaults.standard.string(forKey: "SavedCity") {
            await fetchWeather(for: savedCity)
        }
    }
    
    private func saveCity(cityName: String) {
        UserDefaults.standard.set(cityName, forKey: "SavedCity")
    }
}
