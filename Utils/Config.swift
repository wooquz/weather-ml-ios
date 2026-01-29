//
// Config.swift
// WeatherML
//
// Created by wooquz on 29.01.2026.
//

import Foundation

/// Конфигурация приложения
struct Config {
    /// API ключ для OpenWeatherMap
    static let apiKey = "YOUR_API_KEY_HERE"
    
    /// Базовый URL для API
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    
    /// Единицы измерения
    static let units = "metric"
    
    /// Язык ответа
    static let language = "ru"
}
