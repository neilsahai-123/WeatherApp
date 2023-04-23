//
//  CityView.swift
//  WeatherApp
//
//  Created by Neil Sahai on 09/04/23.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityVM: CityViewModal
    var body: some View {
        VStack {
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 0)
            TodayWeatherView(cityVM: cityVM)
            HourlyWeatherView(cityVM: cityVM)
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityVM: CityViewModal())
    }
}
