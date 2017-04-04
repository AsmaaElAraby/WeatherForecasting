//
//  MesurementsConversionManager.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class MesurementsConversionManager: NSObject {
    
    /// Convert tempreture degree from F to C
    ///
    /// - Parameter kelvinTemp: Double
    /// - Returns:  Int
    static func kelvinToCelsius(kelvinTemp: Double) -> Int {
        return Int(kelvinTemp - 273.15)
    }
    
    
    /// Convert the wind degree to an equivallent direction of the wind
    ///
    /// - Parameter degree: Double
    /// - Returns:  String
    static func windDirectionFromDegrees(degree: Double) -> String {
    
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let degreeOfDirection = ((degree + 11.25)/22.5).truncatingRemainder(dividingBy: 16);
        let degreeOfDirectionAsInt = Int(degreeOfDirection)
        return directions[degreeOfDirectionAsInt];
    }
    
}
