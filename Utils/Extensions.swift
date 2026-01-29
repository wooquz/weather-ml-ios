//
// Extensions.swift
// WeatherML
//
// Created by wooquz on 29.01.2026.
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    /// Форматирование даты для отображения
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    /// Получение дня недели
    var weekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: self)
    }
    
    /// Получение короткой даты
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: self)
    }
}

// MARK: - Double Extensions
extension Double {
    /// Форматирование температуры
    var temperatureString: String {
        return String(format: "%.0f°C", self)
    }
    
    /// Округление до одного знака
    var rounded1: String {
        return String(format: "%.1f", self)
    }
}

// MARK: - Color Extensions
extension Color {
    /// Цвет для различных погодных условий
    static func weatherColor(for temperature: Double) -> Color {
        switch temperature {
        case ..<0:
            return .blue
        case 0..<10:
            return .cyan
        case 10..<20:
            return .green
        case 20..<30:
            return .orange
        default:
            return .red
        }
    }
    
    /// Градиент для фона
    static var weatherGradient: [Color] {
        return [.blue.opacity(0.6), .cyan.opacity(0.4)]
    }
}

// MARK: - String Extensions
extension String {
    /// Капитализация первой буквы
    var capitalizedFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
