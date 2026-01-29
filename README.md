# WeatherML iOS

## Описание

Приложение для прогнозирования погоды с использованием машинного обучения CoreML и интеграции с OpenWeatherMap API. Современное iOS приложение, которое использует ML модели для предсказания погодных условий и предоставляет точные прогнозы погоды на неделю вперед.

## Возможности

- 🤖 Предсказание погоды с использованием CoreML
- 🌤️ Интеграция с OpenWeatherMap API
- 📊 Прогноз на 7 дней
- 🎨 Современный SwiftUI интерфейс
- 📍 Определение местоположения
- 🌡️ Детальная информация о температуре, влажности, давлении
- 💨 Данные о ветре и осадках
- 🌅 Время восхода и заката

## Требования

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- OpenWeatherMap API ключ

## Установка

1. Клонируйте репозиторий:

```bash
git clone https://github.com/wooquz/weather-ml-ios.git
cd weather-ml-ios
```

2. Откройте проект в Xcode:

```bash
open WeatherML.xcodeproj
```

3. Добавьте ваш API ключ OpenWeatherMap в `Config.swift`:

```swift
struct Config {
    static let apiKey = "YOUR_API_KEY_HERE"
}
```

4. Соберите и запустите проект

## Использование

```swift
import WeatherML

let weatherService = WeatherService()
let forecast = await weatherService.getForecast(for: location)
```

## Структура проекта

```
WeatherML/
├── Models/
│   ├── WeatherData.swift
│   ├── Forecast.swift
│   └── MLModel.mlmodel
├── Views/
│   ├── MainView.swift
│   ├── ForecastView.swift
│   └── DetailView.swift
├── Services/
│   ├── WeatherService.swift
│   ├── LocationService.swift
│   └── MLPredictionService.swift
└── Utils/
    ├── Config.swift
    └── Extensions.swift
```

## ML Модель

Приложение использует CoreML модель, обученную на исторических данных погоды для улучшения точности прогнозов.

## Лицензия

MIT License

---

# WeatherML iOS

## Description

iOS weather forecasting application with CoreML machine learning and OpenWeatherMap API integration. Modern iOS app that uses ML models to predict weather conditions and provides accurate 7-day weather forecasts.

## Features

- 🤖 Weather prediction using CoreML
- 🌤️ OpenWeatherMap API integration
- 📊 7-day forecast
- 🎨 Modern SwiftUI interface
- 📍 Location detection
- 🌡️ Detailed temperature, humidity, pressure info
- 💨 Wind and precipitation data
- 🌅 Sunrise and sunset times

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- OpenWeatherMap API key

## Installation

1. Clone the repository:

```bash
git clone https://github.com/wooquz/weather-ml-ios.git
cd weather-ml-ios
```

2. Open project in Xcode:

```bash
open WeatherML.xcodeproj
```

3. Add your OpenWeatherMap API key in `Config.swift`:

```swift
struct Config {
    static let apiKey = "YOUR_API_KEY_HERE"
}
```

4. Build and run

## Usage

```swift
import WeatherML

let weatherService = WeatherService()
let forecast = await weatherService.getForecast(for: location)
```

## Project Structure

```
WeatherML/
├── Models/
│   ├── WeatherData.swift
│   ├── Forecast.swift
│   └── MLModel.mlmodel
├── Views/
│   ├── MainView.swift
│   ├── ForecastView.swift
│   └── DetailView.swift
├── Services/
│   ├── WeatherService.swift
│   ├── LocationService.swift
│   └── MLPredictionService.swift
└── Utils/
    ├── Config.swift
    └── Extensions.swift
```

## ML Model

The app uses a CoreML model trained on historical weather data to improve forecast accuracy.

## License

MIT License
