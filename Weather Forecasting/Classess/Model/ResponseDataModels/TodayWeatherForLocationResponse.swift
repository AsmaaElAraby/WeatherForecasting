//
//  TodayWeatherForLocationResponse.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct TodayWeatherForLocationResponse: Codable {
    

    let coordinates:        LocationCoordinatesDataModel
    let weather:            [WeatherStateDataModel]
    let base:               String
    let tempretureDetails:  TempretureDetailsDataModel
    let visibility:         Int
    let wind:               WindDetailsDataModel
    let clouds:             CloudsDetailsDataModel
    let dateTimeStamp:      Int
    let sunDetails:         SunDetailsDataModel
    let id:                 Int
    let name:               String
    let code:               Int

    var dateDay:        String {
        return Date.timeStampToDayOfTheWeek(timeInterval: Double(dateTimeStamp)) ?? ""
    }

    
    enum CodingKeys: String, CodingKey {
        case    coordinates         =   "coord"
        case    weather
        case    base
        case    tempretureDetails   =   "main"
        case    visibility
        case    wind
        case    clouds
        case    dateTimeStamp       =   "dt"
        case    sunDetails          =   "sys"
        case    id
        case    name
        case    code                =   "cod"
    }

}
