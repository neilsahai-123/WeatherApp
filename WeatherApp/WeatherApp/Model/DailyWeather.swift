//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import Foundation

struct DailyWeather: Codable, Identifiable{
    var dt: Int?
    var temp: Temprature?
    var weather: [WeatherDetails]?
    
    enum CodingKey: String{
        case dt
        case temp
        case weather
    }
    
    init(){
        dt = 0
        temp = Temprature(min: 0.0, max: 0.0)
        weather = [WeatherDetails(main: "", description: "", icon: "")]
    }
}

extension DailyWeather{
    var id: UUID{
        return UUID()
    }
}
