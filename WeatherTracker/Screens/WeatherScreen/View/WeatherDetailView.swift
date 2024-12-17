//
//  WeatherDetailView.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import SwiftUI

struct WeatherDetailView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: Weather
    @State private var searchTerm: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            // MARK: - Weather Icon & Location
            weatherHeaderView
            
            // MARK: - Temperature Display
            temperatureView
            
            // MARK: - Weather Info Cards
            weatherInfoCards
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Weather Header View
    private var weatherHeaderView: some View {
        VStack(alignment: .center, spacing: 12) {
            // Weather Icon
            if let iconURL = URL(string: weather.iconURL) {
                AsyncImage(url: iconURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                } placeholder: {
                    ProgressView()
                }
            }
            
            // City Name with Location Icon
            HStack {
                Text(weather.cityName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Image(systemName: "location.fill")
                    .foregroundColor(.black)
            }
        }
    }
    
    // MARK: - Temperature View
    private var temperatureView: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text("\(weather.temperature, specifier: "%.f")")
                .font(.system(size: 64))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("°")
                .font(.system(size: 32, weight: .light))
                .foregroundColor(.primary)
                .offset(y: -32)
        }
    }
    
    // MARK: - Weather Info Cards
    private var weatherInfoCards: some View {
        HStack {
            WeatherInfoView(label: "Humidity", value: "\(Int(weather.humidity))%")
            Spacer()
            WeatherInfoView(label: "UV", value: "\(Int(weather.uvIndex))")
            Spacer()
            WeatherInfoView(label: "Feels Like", value: "\(Int(weather.feelsLike))°")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Weather Info View
struct WeatherInfoView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
#Preview {
    WeatherDetailView(weather: Weather.mock)
        .environmentObject(WeatherViewModel(networkService: NetworkService()))
}

