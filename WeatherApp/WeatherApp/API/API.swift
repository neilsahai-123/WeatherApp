//
//  API.swift
//  WeatherApp
//
//  Created by Neil Sahai on 02/04/23.
//

import Foundation

struct API {
    static let key = "ed70bf044f3e2ba4263b17fad9def599"
    static let baseUrlString = "https://api.openweathermap.org/data/3.0/"
    
    static func getURLFor(lat: Double, long: Double) -> String {
        return "\(baseUrlString)onecall?lat=\(lat)&lon=\(long)&exclude=minutely&appid=\(key)&units=metric"
    }
}
