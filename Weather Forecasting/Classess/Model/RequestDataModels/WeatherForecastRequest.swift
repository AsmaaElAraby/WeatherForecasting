//
//  WeatherForecastRequest.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherForecastRequest: Codable {

    let latitude:       Double
    let longitude:      Double
    let numberOfDays:   String?
    let appId:          String = WeatherMapKey.AppId.rawValue

    enum CodingKeys: String, CodingKey {
        case latitude       = "lat"
        case longitude      = "lon"
        case numberOfDays   = "cnt"
        case appId          = "appid"
    }
}
