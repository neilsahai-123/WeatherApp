//
//  CityViewModal.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import SwiftUI
import CoreLocation

final class CityViewModal: ObservableObject{
    
    @Published var weather =  WeatherResponse.empty()
    @Published var city: String = "San Fransisco"{
        didSet{
            //call get lostion here
        }
    }
    
    private lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init(){
        //getLocation
    }
    
    var date: String{
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String{
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    var temperature: String{
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0{
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String {
        return weather.current.wind_speed.toString()
    }
    
    var humidity: String {
        return weather.current.humidity.toString()
    }
    
    var rainChancel: String {
        return weather.current.dew_point.toString()
    }
    
    func getTimeFor(timestamp: Double) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String{
        return String(format: "0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let url = API.getURLFor(lat: coord.latitude, long: coord.longitude)
        }
    }
}
