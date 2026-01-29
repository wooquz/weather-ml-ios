import SwiftUI

struct DetailView: View {
    let forecast: Forecast
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Дата
                HStack {
                    Text("Дата:")
                        .font(.headline)
                    Spacer()
                    Text(forecast.date, style: .date)
                        .font(.body)
                }
                
                // Температура
                HStack {
                    Text("Температура:")
                        .font(.headline)
                    Spacer()
                    Text("\(String(format: "%.1f", forecast.temperature))°C")
                        .font(.title)
                }
                
                // Условия
                HStack {
                    Text("Условия:")
                        .font(.headline)
                    Spacer()
                    Text(forecast.condition)
                        .font(.body)
                }
                
                // Влажность
                HStack {
                    Text("Влажность:")
                        .font(.headline)
                    Spacer()
                    Text("\(forecast.humidity)%")
                        .font(.body)
                }
                
                // Скорость ветра
                HStack {
                    Text("Скорость ветра:")
                        .font(.headline)
                    Spacer()
                    Text("\(String(format: "%.1f", forecast.windSpeed)) м/с")
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Детали прогноза")
    }
}
