//
// WeatherMLApp.swift
// WeatherML
//
// Created by wooquz on 29.01.2026.
//

import SwiftUI

@main
struct WeatherMLApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фоновый градиент
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.6), .cyan.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                        .scaleEffect(1.5)
                        .tint(.white)
                        .foregroundColor(.white)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 20) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                        Text(error)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Повторить") {
                            viewModel.refreshWeather()
                        }
                        .padding()
                        .background(.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                } else if let weather = viewModel.weatherData {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Текущая погода
                            VStack(spacing: 10) {
                                Text(weather.location.cityName)
                                    .font(.system(size: 36, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Text(weather.current.formattedTemperature)
                                    .font(.system(size: 72, weight: .thin))
                                    .foregroundColor(.white)
                                
                                Text(weather.current.description.capitalized)
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.top, 50)
                            
                            // Прогноз
                            if let forecast = viewModel.forecast {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Прогноз на неделю")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                    
                                    ForEach(forecast.days) { day in
                                        HStack {
                                            Text(day.formattedDate)
                                                .foregroundColor(.white)
                                                .frame(width: 100, alignment: .leading)
                                            
                                            Image(systemName: "cloud.sun.fill")
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Text(day.temperature.rangeString)
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .background(.white.opacity(0.2))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.top, 20)
                            }
                        }
                    }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "location.circle")
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                        Text("Разрешите доступ к геолокации")
                            .font(.title2)
                            .foregroundColor(.white)
                        Button("Разрешить") {
                            viewModel.requestLocationPermission()
                        }
                        .padding()
                        .background(.white.opacity(0.3))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("Погода")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.refreshWeather()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear {
            viewModel.requestLocationPermission()
        }
    }
}
