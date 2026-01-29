//
//  LocationService.swift
//  WeatherML
//
//  Created by wooquz on 29.01.2026.
//

import Foundation
import CoreLocation
import Combine

/// Сервис для работы с геолокацией
class LocationService: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var errorMessage: String?
    
    override init() {
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Запрос разрешения на использование геолокации
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// Получение текущего местоположения
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    /// Начало постоянного отслеживания местоположения
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    /// Остановка отслеживания местоположения
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.errorMessage = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.errorMessage = error.localizedDescription
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
}
