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
    let main:           TemperatureDataModel
    let weather:        [WeatherStateDataModel]
    let clouds:         CloudsDetailsDataModel
    let wind:           WindDetailsDataModel
    let rain:           RainDetails
    let sysDetails:     SysDetails
    let dateAsText:     String
    
    
    enum CodingKeys: String, CodingKey {
        case    dateTimeStamp   =   "dt"
        case    main
        case    weather
        case    clouds
        case    wind
        case    rain
        case    sysDetails      =   "sys"
        case    dateAsText      =   "dt_txt"
    }
    
    var dateDay:    String {
        return Date.timeStampToDayOfTheWeek(timeInterval: Double(dateTimeStamp)) ?? ""
    }
    
    var hour:    String {
        return Date.timeStampToDayHour(timeInterval: Double(dateTimeStamp)) ?? ""
    }
}

struct RainDetails: Codable {
    let volumeForLast3h: Double?
    
    enum CodingKeys: String, CodingKey {
        case    volumeForLast3h   =   "3h"
    }
}

struct SysDetails: Codable {
    let pod:    String?
}
