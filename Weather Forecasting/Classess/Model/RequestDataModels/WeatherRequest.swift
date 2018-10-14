//
//  WeatherRequest.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherRequest: Codable {
    
    let latitude: Double
    let longitude: Double
    let appId: String = WeatherMap.key.rawValue
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case appId = "appid"
    }
    
}
