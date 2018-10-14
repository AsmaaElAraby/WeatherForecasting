//
//  TemperatureHandler.swift
//  Weather Forecasting
//
//  Created by Asma on 10/13/18.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation

class TemperatureHandler {
    
    /// Convert tempreture degree from F to C
    ///
    /// - Parameter kelvinTemp: Double
    /// - Returns:  Int
    static func kelvinToCelsius(degree: Double) -> Int {
        return Int(degree - 273.15)
    }
    
}
