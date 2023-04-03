//
//  ContentView.swift
//  WeatherApp
//
//  Created by Neil Sahai on 30/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityViewModal()
    private let gradient = LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeaderView(cityVM: cityVM)
                ScrollView(showsIndicators: false) {
                    CityView(cityVM: cityVM)
                }
            }.padding(.top, 40)
        }
        .background(gradient)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
