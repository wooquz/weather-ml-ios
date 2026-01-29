import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Текущая погода
                    if let weather = viewModel.currentWeather {
                        CurrentWeatherCard(weather: weather)
                    }
                    
                    // Прогноз погоды
                    if !viewModel.forecasts.isEmpty {
                        NavigationLink(destination: ForecastView(forecasts: viewModel.forecasts)) {
                            ForecastListCard(forecasts: viewModel.forecasts)
                        }
                    }
                    
                    // ML предсказание
                    if let mlPrediction = viewModel.mlPrediction {
                        MLPredictionCard(prediction: mlPrediction)
                    }
                }
                .padding()
            }
            .navigationTitle("WeatherML")
            .onAppear {
                viewModel.loadWeatherData()
            }
        }
    }
}
