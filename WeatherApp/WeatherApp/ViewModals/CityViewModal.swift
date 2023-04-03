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
    @Published var city: String = "San Francisco"{
        didSet{
            //call get lostion here
            getLocation()
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
        getLocation()
    }
    
    var date: String{
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current?.dt ?? 0.0)))
    }
    
    var weatherIcon: String{
        if let weather = weather.current?.weather,
            weather.count > 0 {
            return weather.first?.icon ?? "dayClearSky"
        }
        return "dayClearSky"
    }
    
    var temperature: String{
        if let temp = weather.current?.temp {
            return getTempFor(temp: temp)
        }
        return ""
    }
    
    var conditions: String {
        if let weather = weather.current?.weather, weather.count > 0,
        let main = weather.first?.main {
            return main
        }
        return ""
    }
    
    var windSpeed: String {
        if let wind_speed = weather.current?.wind_speed {
            return wind_speed.toString()
        }
        return ""
    }
    
    var humidity: String {
        if let humidity = weather.current?.humidity {
            return humidity.toString()
        }
        return ""
    }
    
    var rainChances: String {
        if let dewPoint = weather.current?.dew_point {
            return dewPoint.toString()
        }
        return ""
    }
    
    func getTimeFor(timestamp: Double) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String{
        return temp.toString()
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let url = API.getURLFor(lat: coord.latitude, long: coord.longitude)
            getWeatherInternal(city: city, for: url)
        } else {
            let urlString = API.getURLFor(lat: 18.618070014377903, long: 73.89858210193616)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { placeMarks, error in
            if let place = placeMarks?.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        NetworkManager<WeatherResponse>.fetch(for: url) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLottieAnimationForIcon(icon: String) -> String {
        switch icon {
        case "01d" :
            return "dayClearSky"
        case "01n" :
            return "nightClearSky"
        case "02d" :
            return "dayFewClouds"
        case "02n" :
            return "nightFewClouds"
        case "03d" :
            return "dayScatteredClouds"
        case "03n" :
            return "nightScatteredClouds"
        case "04d" :
            return "dayBrokenClouds"
        case "04n" :
            return "nightBrokenClouds"
//        case "05d" :
//            return ""
//        case "05n":
//            return ""
//        case "06d" :
//            return ""
//        case "06n":
//            return ""
//        case "07d" :
//            return ""
//        case "07n":
//            return ""
//        case "08n":
//            return ""
//        case "08d" :
//            return ""
        case "09d" :
            return "dayShowerRains"
        case "09n":
            return "nightShowerRains"
        case "10d" :
            return "dayRains"
        case "10n":
            return "nightRains"
        case "11d" :
            return "dayThunderstorm"
        case "11n":
            return "nightThunderstorm"
        case "13d" :
            return "daySnow"
        case "13n":
            return "nightSnow"
        case "50d":
            return "dayMist"
        case "50n":
            return "nightMist"
        default:
            return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d" :
            return Image(systemName: "sun.max.fill")
        case "01n" :
            return Image(systemName: "moon.fill")
        case "02d" :
            return Image(systemName: "cloud.sun.fill")
        case "02n" :
            return Image(systemName: "cloud.moon.fill")
        case "03d" :
            return Image(systemName: "cloud.fill")
        case "03n" :
            return Image(systemName: "cloud.fill")
        case "04d" :
            return Image(systemName: "cloud.fill")
        case "04n" :
            return Image(systemName: "cloud.fill")
        case "09d" :
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d" :
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d" :
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d" :
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}
