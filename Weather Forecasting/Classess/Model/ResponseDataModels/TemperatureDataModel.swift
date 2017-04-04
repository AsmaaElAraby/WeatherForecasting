//
//  TemperatureDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum TemperatureResponseParameters: String  {
    case Day    =   "day"
    case Minimum    =   "min"
    case Maximum    =   "max"
    case Night  =   "night"
    case Evening    =   "eve"
    case Morning   =   "morn"
}

class TemperatureDataModel: NSObject {
    
    private var minimum:    Double!
    private var maximum:    Double!
    private var morning:    Double!
    private var day:        Double!
    private var evening:    Double!
    private var night:      Double!
    
    
    /// create instance from TemperatureDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
    
        if let day = data[TemperatureResponseParameters.Day.rawValue] {
            self.day = day.double
        }
        
        if let minimum = data[TemperatureResponseParameters.Minimum.rawValue] {
            self.minimum = minimum.double
        }
        
        if let maximum = data[TemperatureResponseParameters.Maximum.rawValue] {
            self.maximum = maximum.double
        }
        
        if let night = data[TemperatureResponseParameters.Night.rawValue] {
            self.night = night.double
        }
        
        if let evening = data[TemperatureResponseParameters.Evening.rawValue] {
            self.evening = evening.double
        }
        
        if let morning = data[TemperatureResponseParameters.Morning.rawValue] {
            self.morning = morning.double
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getDay() -> Double {
        return self.day
    }
    
    internal func getMinimum() -> Double {
        return self.minimum
    }
    
    internal func getMaximum() -> Double {
        return self.maximum
    }
    
    internal func getNight() -> Double {
        return self.night
    }
    
    internal func getEvening() -> Double {
        return self.evening
    }
    
    internal func getMorning() -> Double {
        return self.morning
    }
    
    
    /// get the appropriate tempreture according to the current day interval
    ///
    /// - Returns: Double
    internal func getAppropriateTempreture() -> Double {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12 : return self.morning
        case 12..<17 : return self.day
        case 17..<22 : return self.evening
        default: return self.night
        }
        
    }
}
