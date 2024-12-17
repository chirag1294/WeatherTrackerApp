//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var searchTerm: String = ""
    @State private var showResultCard: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - Search Bar
                    CustomSearchView(searchText: searchTerm) { city in
                        Task {
                            showResultCard = true
                            await viewModel.fetchWeather(for: city)
                        }
                    }
                    .padding()

                    // MARK: - Weather Results
                    contentView
                    
                    Spacer()
                }
                .onAppear {
                    Task {
                        await viewModel.loadSavedCity()
                    }
                }
            }
        }
    }
    
    // MARK: - Content View Logic
    @ViewBuilder
    private var contentView: some View {
        if let weather = viewModel.weather {
            if showResultCard {
                ResultCardView(weather: weather)
                    .padding()
                    .onTapGesture {
                        Task {
                            showResultCard = false
                            await viewModel.fetchWeather(for: weather.cityName)
                        }
                    }
            } else {
                WeatherDetailView(weather: weather)
                    .padding()
            }
        } else {
            Spacer()
            
            EmptyStateView()
                .padding()
        }
    }
}

// MARK: - Empty State View
struct EmptyStateView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("No City Selected")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("Please search for a city")
                .fontWeight(.bold)
        }
        .padding()
    }
}

#Preview {
    @Previewable @StateObject var viewModel = WeatherViewModel(networkService: NetworkService())
    
    return ContentView()
        .environmentObject(viewModel)
}
