//
//  API.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import SwiftUI

struct API {
    static let key = "6c0e8bb866a15f9b58737666791fed9f"
    static let baseUrlString = "https://api.openweathermap.org/data/3.0"
    
    static func getURLFor(lat: Double, long: Double) -> String {
        return "\(baseUrlString)onecall?lat=\(lat)&lon=\(long)&exclude=hourly,daily&appid=\(key)&units=imperial"
    }
}
