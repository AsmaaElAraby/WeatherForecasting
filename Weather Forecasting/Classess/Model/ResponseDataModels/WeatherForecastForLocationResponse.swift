//
//  WeatherDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherForecastForLocationResponse: Codable {
    
    let cityData:           CurrentLocationDataModel?
    let code:               String?
    let message:            Double?
    let numberOfDays:       Int?
    let listOfDays:         [WeatherForADayDataModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case    cityData        =   "city"
        case    code            =   "cod"
        case    message
        case    numberOfDays    =   "cnt"
        case    listOfDays      =   "list"
    }
    
}
