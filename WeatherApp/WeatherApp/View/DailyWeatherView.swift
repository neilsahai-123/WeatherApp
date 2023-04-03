//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var cityVM: CityViewModal
    private let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)
    
    var body: some View {
        VStack {
            if let dailyList = cityVM.weather.daily {
                ForEach(dailyList) { weather in
                    LazyVStack {
                        dailyView(weather: weather)
                    }
                }
            }
        }
        
    }
    
    private func dailyView(weather: DailyWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt ?? 0).uppercased())
                .frame(width: 50)
            Spacer()
            if let max = weather.temp?.max,
               let min = weather.temp?.min {
                Text("\(max) | \(cityVM.getTimeFor(timestamp: min)) ℉")
                    .frame(width: 150)
                Spacer()
            }
            
            
            if let weather = weather.weather,
               weather.count > 0,
               let icon = weather.first?.icon {
                cityVM.getWeatherIconFor(icon: icon)
            } else {
                cityVM.getWeatherIconFor(icon: "sun.max.fill")
            }
            
        }.foregroundColor(.white)
            .padding(.horizontal, 40)
            .padding(.vertical, 50)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(gradient)
                    .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                    .shadow(color: Color.white.opacity(0.2), radius: 2, x: -2, y: -2)
            }
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(cityVM: CityViewModal())
    }
}
