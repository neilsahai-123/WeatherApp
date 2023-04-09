//
//  Extension.swift
//  WeatherApp
//
//  Created by Neil Sahai on 09/04/23.
//

import Foundation

extension Double {
    func toString(decimal: Int = 2) -> String {
        let string = String(format: "%.2f", self)
        return string
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}
