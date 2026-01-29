//
// WeatherViewModel.swift
// WeatherML
//
// Created by wooquz on 29.01.2026.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var forecast: Forecast?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherService
    private let locationService: LocationService
    private let mlService: MLPredictionService
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.weatherService = WeatherService()
        self.locationService = LocationService()
        self.mlService = MLPredictionService()
        
        setupLocationObserver()
    }
    
    private func setupLocationObserver() {
        locationService.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                Task {
                    await self?.fetchWeather(for: location)
                }
            }
            .store(in: &cancellables)
        
        locationService.$errorMessage
            .sink { [weak self] error in
                self?.errorMessage = error
            }
            .store(in: &cancellables)
    }
    
    func requestLocationPermission() {
        locationService.requestLocationPermission()
    }
    
    func refreshWeather() {
        locationService.requestLocation()
    }
    
    private func fetchWeather(for location: CLLocation) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Получаем текущую погоду и прогноз
            async let currentWeatherTask = try await weatherService.getCurrentWeather(for: location)
            async let forecastTask = try await weatherService.getForecast(for: location)
            
            let (currentWeather, forecastData) = try await (currentWeatherTask, forecastTask)
            
            // Преобразуем данные в наши модели
            let cityName = try await getCityName(for: location)
            let locationData = LocationData(coordinate: location.coordinate, cityName: cityName)
            
            self.weatherData = WeatherData(
                location: locationData,
                current: currentWeather,
                sunrise: Date(),
                sunset: Date()
            )
            
            // Обрабатываем прогноз с ML
            let days = processForecastData(forecastData)
            self.forecast = Forecast(days: days)
            
        } catch {
            self.errorMessage = "Ошибка загрузки данных: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func getCityName(for location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        return placemarks.first?.locality ?? "Неизвестно"
    }
    
    private func processForecastData(_ forecastData: ForecastData) -> [DayForecast] {
        // Группируем данные по дням и создаем прогноз на каждый день
        var days: [DayForecast] = []
        let calendar = Calendar.current
        var currentDate: Date?
        var dailyTemps: [Double] = []
        var dailyData: (main: ForecastData.WeatherItem.MainData, 
                        weather: ForecastData.WeatherItem.WeatherDescription, 
                        wind: ForecastData.WeatherItem.WindData)?
        
        for item in forecastData.list.prefix(40) {
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            let itemDate = calendar.startOfDay(for: date)
            
            if currentDate == nil {
                currentDate = itemDate
            }
            
            if itemDate != currentDate, let currentDay = currentDate {
                if let data = dailyData, !dailyTemps.isEmpty {
                    let tempRange = TemperatureRange(
                        min: dailyTemps.min() ?? 0,
                        max: dailyTemps.max() ?? 0,
                        day: dailyTemps.reduce(0, +) / Double(dailyTemps.count),
                        night: dailyTemps.first ?? 0
                    )
                    
                    var dayForecast = DayForecast(
                        date: currentDay,
                        temperature: tempRange,
                        humidity: data.main.humidity,
                        pressure: data.main.pressure,
                        windSpeed: data.wind.speed,
                        precipitation: 0,
                        description: data.weather.description,
                        icon: data.weather.icon
                    )
                    
                    // Улучшаем прогноз с помощью ML
                    dayForecast = mlService.enhanceForecast(dayForecast)
                    days.append(dayForecast)
                    
                    if days.count >= Config.forecastDays {
                        break
                    }
                }
                
                currentDate = itemDate
                dailyTemps = []
                dailyData = nil
            }
            
            dailyTemps.append(item.main.temp)
            if dailyData == nil, let weather = item.weather.first {
                dailyData = (item.main, weather, item.wind)
            }
        }
        
        return days
    }
}
