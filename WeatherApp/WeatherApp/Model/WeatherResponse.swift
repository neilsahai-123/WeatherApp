//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import Foundation


struct WeatherResponse: Codable {
    var current: Weather?
    var hourly: [Weather]?
    var daily: [DailyWeather]?
    
    static func empty() -> WeatherResponse{
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
}
