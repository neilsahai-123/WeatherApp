//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import SwiftUI

struct HourlyWeatherView: View {
    
    @ObservedObject var cityVM: CityViewModal
    private let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if let items = cityVM.weather.hourly {
                    ForEach(items) { weather in
                        let iconName = weather.weather?.first?.icon ?? "sun.max.fill"
                        let icon = cityVM.getWeatherIconFor(icon: iconName)
                        let hour = cityVM.getTimeFor(timestamp: weather.dt ?? 0.0)
                        let temp = cityVM.getTempFor(temp: weather.temp ?? 0.0)
                        getHourlyView(hour: hour, image: icon, temp: temp)
                    }
                }
               
            }
        }
    }
    
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 10) {
            Text(hour)
            image
                .foregroundColor(.yellow)
            Text(temp)
        }
        .foregroundColor(.white)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(gradient)
                .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                .shadow(color: Color.white.opacity(0.2), radius: 2, x: -2, y: -2)
        }
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(cityVM: CityViewModal())
    }
}
