//
//  WeatherData.swift
//  WeatherML
//
//  Created by wooquz on 29.01.2026.
//

import Foundation
import CoreLocation

/// Основная модель данных о погоде
struct WeatherData: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let location: LocationData
    let current: CurrentWeather
    let sunrise: Date
    let sunset: Date
    
    init(location: LocationData, current: CurrentWeather, sunrise: Date, sunset: Date) {
        self.id = UUID()
        self.timestamp = Date()
        self.location = location
        self.current = current
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

/// Данные о местоположении
struct LocationData: Codable {
    let latitude: Double
    let longitude: Double
    let cityName: String
    
    init(coordinate: CLLocationCoordinate2D, cityName: String = "Unknown") {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.cityName = cityName
    }
}

/// Текущие погодные условия
struct CurrentWeather: Codable {
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let windDirection: Int
    let cloudiness: Int
    let visibility: Int
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case pressure
        case windSpeed = "wind_speed"
        case windDirection = "wind_deg"
        case cloudiness = "clouds"
        case visibility
        case description
        case icon
    }
    
    /// Форматированная температура с символом градуса
    var formattedTemperature: String {
        return String(format: "%.0f°C", temperature)
    }
    
    /// Форматированная температура "ощущается как"
    var formattedFeelsLike: String {
        return String(format: "%.0f°C", feelsLike)
    }
    
    /// URL иконки погоды
    var iconURL: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}
