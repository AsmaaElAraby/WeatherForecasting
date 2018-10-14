//
//  WeatherForecastRequest.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherForecastRequest: Codable {
    
    let latitude:       Double
    let longitude:      Double
    let appId:          String = WeatherMapKey.AppId.rawValue
    
    enum CodingKeys: String, CodingKey {
        case latitude       = "lat"
        case longitude      = "lon"
        case appId          = "appid"
    }
}
