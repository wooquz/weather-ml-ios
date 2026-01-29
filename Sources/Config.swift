//
// Config.swift
// WeatherML
//
// Created by wooquz on 29.01.2026.
//

import Foundation

/// Конфигурация приложения
struct Config {
    /// API ключ OpenWeatherMap
    /// Получите ваш ключ на https://openweathermap.org/api
    static let apiKey = "YOUR_API_KEY_HERE"
    
    /// Базовый URL для API
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    
    /// Единицы измерения (metric, imperial, standard)
    static let units = "metric"
    
    /// Язык для ответов API
    static let language = "ru"
    
    /// Количество дней для прогноза
    static let forecastDays = 7
    
    /// Таймаут для сетевых запросов (в секундах)
    static let requestTimeout: TimeInterval = 30
}
