//
//  TodayWindDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct WindDetailsDataModel: Codable {
    
    let speed:  Double
    let degree: Double
    
    
    enum CodingKeys: String, CodingKey {
        case    speed
        case    degree  =   "deg"
    }
    
}

