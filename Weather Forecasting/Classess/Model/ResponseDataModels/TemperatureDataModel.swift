//
//  TemperatureDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct TemperatureDataModel: Codable {
    
    let minimum:    Double
    let maximum:    Double
    let morning:    Double
    let day:        Double
    let evening:    Double
    let night:      Double
    
    
    enum CodingKeys: String, CodingKey {
        case minimum    = "min"
        case maximum    = "max"
        case morning    = "morn"
        case day
        case evening    = "eve"
        case night      = "night"
    }
    
    /// get the appropriate tempreture according to the current day interval
    ///
    /// - Returns: Double
    var appropriateTempreture: Double {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12 : return self.morning
        case 12..<17 : return self.day
        case 17..<22 : return self.evening
        default: return self.night
        }
        
    }
}
