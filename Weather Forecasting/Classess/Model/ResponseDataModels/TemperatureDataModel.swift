//
//  TemperatureDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct TemperatureDataModel: Codable {
    
    let temperature:    Double
    let minimum:    Double
    let maximum:    Double
    let pressure:   Double
    let seaLevel:   Double
    let groundLevel:  Double
    let humidity:   Double
    let tempKF:     Double
    
    enum CodingKeys: String, CodingKey {
        case temperature    = "temp"
        case minimum    = "temp_min"
        case maximum    = "temp_max"
        case pressure
        case seaLevel   = "sea_level"
        case groundLevel    = "grnd_level"
        case humidity
        case tempKF     = "temp_kf"
    }
    
}
