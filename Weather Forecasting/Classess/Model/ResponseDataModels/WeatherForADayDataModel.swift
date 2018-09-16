//
//  WeatherForecastDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherForADayDataModel: Codable {
    
    let dateTimeStamp:  Int
    let temperature:    TemperatureDataModel
    let pressure:       Double
    let humidity:       Double
    let weather:        [WeatherStateDataModel]
    let speed:          Double
    let degree:         Double
    let clouds:         Double
    
    
    
    enum CodingKeys: String, CodingKey {
        case    dateTimeStamp   =   "dt"
        case    temperature =   "temp"
        case    pressure
        case    humidity
        case    weather
        case    speed
        case    degree      =   "deg"
        case    clouds
    }
    
    var dateDay:    String {
        return Date.timeStampToDayOfTheWeek(timeInterval: Double(dateTimeStamp)) ?? ""
    }
    
}
