import SwiftUI

struct ForecastView: View {
    let forecasts: [Forecast]
    
    var body: some View {
        List(forecasts, id: \.date) { forecast in
            NavigationLink(destination: DetailView(forecast: forecast)) {
                ForecastRow(forecast: forecast)
            }
        }
        .navigationTitle("Прогноз погоды")
    }
}

struct ForecastRow: View {
    let forecast: Forecast
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(forecast.date, style: .date)
                    .font(.headline)
                Text("Температура: \(String(format: "%.1f", forecast.temperature))°C")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: weatherIcon(for: forecast.condition))
                .font(.title)
        }
    }
    
    private func weatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case let c where c.contains("rain"): return "cloud.rain"
        case let c where c.contains("cloud"): return "cloud"
        case let c where c.contains("sun"), let c where c.contains("clear"): return "sun.max"
        default: return "cloud.sun"
        }
    }
}
