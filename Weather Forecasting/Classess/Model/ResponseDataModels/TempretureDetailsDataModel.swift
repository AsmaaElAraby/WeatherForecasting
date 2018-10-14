//
//  TodayTempretureDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct TempretureDetailsDataModel: Codable {
    
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let temperatureMinimum: Double
    let temperatureMaximum: Double
    
    
    enum CodingKeys: String, CodingKey {
        case    temperature =   "temp"
        case    pressure
        case    humidity
        case    temperatureMinimum     =   "temp_min"
        case    temperatureMaximum     =   "temp_max"
    }
    
}
