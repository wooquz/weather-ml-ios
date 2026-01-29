import Foundation
import CoreLocation

struct WeatherData: Codable {
    let temperature: Double
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case pressure
        case windSpeed = "wind_speed"
        case description
        case icon
    }
}

struct ForecastData: Codable {
    let list: [WeatherItem]
    
    struct WeatherItem: Codable {
        let dt: Int
        let main: MainData
        let weather: [WeatherDescription]
        let wind: WindData
        
        struct MainData: Codable {
            let temp: Double
            let humidity: Int
            let pressure: Int
        }
        
        struct WeatherDescription: Codable {
            let description: String
            let icon: String
        }
        
        struct WindData: Codable {
            let speed: Double
        }
    }
}

class WeatherService {
    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    init(apiKey: String = Config.apiKey) {
        self.apiKey = apiKey
    }
    
    func getCurrentWeather(for location: CLLocation) async throws -> WeatherData {
        let url = "\(baseURL)/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: requestURL)
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherData.self, from: data)
    }
    
    func getForecast(for location: CLLocation) async throws -> ForecastData {
        let url = "\(baseURL)/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: requestURL)
        let decoder = JSONDecoder()
        return try decoder.decode(ForecastData.self, from: data)
    }
}

struct Config {
    static let apiKey = "YOUR_API_KEY_HERE"
}
