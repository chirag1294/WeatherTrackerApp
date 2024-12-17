//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    @StateObject private var viewModel = WeatherViewModel(networkService: NetworkService())

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
            }
        }
}
