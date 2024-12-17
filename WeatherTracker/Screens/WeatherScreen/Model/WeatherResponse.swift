//
//  WeatherResponse.swift
//  WeatherTracker
//
//  Created by Chirag Anghan on 2024-12-17.
//

import Foundation

struct WeatherResponse: Decodable {
    let location: Location
    let current: Current

    struct Location: Decodable {
        let name: String
    }

    struct Current: Decodable {
        let tempC: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        let feelslikeC: Double

        struct Condition: Decodable {
            let text: String
            let icon: String
        }
    }
}

struct Weather {
    let cityName: String
    let temperature: Double
    let condition: String
    let iconURL: String
    let humidity: Int
    let uvIndex: Double
    let feelsLike: Double

    init(from response: WeatherResponse) {
        self.cityName = response.location.name
        self.temperature = response.current.tempC
        self.condition = response.current.condition.text
        self.iconURL = "https:\(response.current.condition.icon)"
        self.humidity = response.current.humidity
        self.uvIndex = response.current.uv
        self.feelsLike = response.current.feelslikeC
    }

    init(cityName: String, temperature: Double, condition: String, iconURL: String, humidity: Int, uvIndex: Double, feelsLike: Double) {
        self.cityName = cityName
        self.temperature = temperature
        self.condition = condition
        self.iconURL = iconURL
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.feelsLike = feelsLike
    }
}


extension Weather {
    static var mock: Weather {
        return Weather(
            cityName: "San Francisco",
            temperature: 20.0,
            condition: "Sunny",
            iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png",
            humidity: 60,
            uvIndex: 5.0,
            feelsLike: 21.0
        )
    }
}

extension WeatherResponse {
    static var mock: WeatherResponse {
        return WeatherResponse(
            location: WeatherResponse.Location(name: "San Francisco"),
            current: WeatherResponse.Current(
                tempC: 20.0,
                condition: WeatherResponse.Current.Condition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"),
                humidity: 60,
                uv: 5.0,
                feelslikeC: 21.0
            )
        )
    }
}
