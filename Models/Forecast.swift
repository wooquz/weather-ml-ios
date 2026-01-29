//
//  Forecast.swift
//  WeatherML
//
//  Created by wooquz on 29.01.2026.
//

import Foundation

/// Модель прогноза погоды на несколько дней
struct Forecast: Codable, Identifiable {
    let id: UUID
    let days: [DayForecast]
    
    init(days: [DayForecast]) {
        self.id = UUID()
        self.days = days
    }
}

/// Прогноз на один день
struct DayForecast: Codable, Identifiable {
    let id: UUID
    let date: Date
    let temperature: TemperatureRange
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let precipitation: Double
    let description: String
    let icon: String
    
    init(date: Date, temperature: TemperatureRange, humidity: Int, pressure: Int, 
         windSpeed: Double, precipitation: Double, description: String, icon: String) {
        self.id = UUID()
        self.date = date
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.precipitation = precipitation
        self.description = description
        self.icon = icon
    }
    
    /// Форматированная дата
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }
    
    /// Короткий формат даты
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
}

/// Диапазон температуры
struct TemperatureRange: Codable {
    let min: Double
    let max: Double
    let day: Double
    let night: Double
    
    /// Форматированная минимальная температура
    var formattedMin: String {
        return String(format: "%.0f°", min)
    }
    
    /// Форматированная максимальная температура
    var formattedMax: String {
        return String(format: "%.0f°", max)
    }
    
    /// Диапазон температуры в одной строке
    var rangeString: String {
        return "\(formattedMin) ... \(formattedMax)"
    }
}
