//
//  WeatherDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WeatherStateDataModel: Codable {

    let id:                         Int
    let main, description, icon:    String
}
