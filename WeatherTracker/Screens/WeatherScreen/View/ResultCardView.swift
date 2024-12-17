//
//  ResultCardView.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import SwiftUI

struct ResultCardView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: Weather
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                // MARK: - Weather Details
                weatherDetailsView(geometry: geometry)
                
                Spacer()
                
                // MARK: - Weather Icon
                weatherIconView(geometry: geometry)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)
        }
        .aspectRatio(3.5, contentMode: .fit)
    }
    
    // MARK: - Weather Details View
    private func weatherDetailsView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(weather.cityName)
                .font(.system(size: geometry.size.width * 0.07, weight: .semibold))
                .foregroundColor(.primary)
            
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(weather.temperature, specifier: "%.f")")
                    .font(.system(size: geometry.size.width * 0.16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text("°")
                    .font(.system(size: geometry.size.width * 0.08, weight: .light))
                    .foregroundColor(.primary)
                    .offset(y: -geometry.size.height * 0.3)
            }
        }
    }
    
    // MARK: - Weather Icon View
    private func weatherIconView(geometry: GeometryProxy) -> some View {
        Group {
            if let iconURL = URL(string: weather.iconURL) {
                AsyncImage(url: iconURL) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                .padding(.trailing, geometry.size.width * 0.05)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ResultCardView(weather: Weather.mock)
        .environmentObject(WeatherViewModel(networkService: NetworkService()))
}
