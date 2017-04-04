//
//  TodayTempretureDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum TempretureDetailsResponseParameters: String  {
    case    Temperature =   "temp"
    case    Pressure    =   "pressure"
    case    Humidity    =   "humidity"
    case    TempretureMinimum     =   "weather"
    case    TempretureMaximum     =   "speed"
}

class TempretureDetailsDataModel: NSObject {
    
    private var temperature:    Double!
    private var pressure:       Int!
    private var humidity:       Double!
    private var temperatureMinimum:    Double!
    private var temperatureMaximum:    Double!
    
    
    /// create instance from TempretureDetailsDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let temperature = data[TempretureDetailsResponseParameters.Temperature.rawValue] {
            self.temperature = temperature.double
        }
        
        if let pressure = data[TempretureDetailsResponseParameters.Pressure.rawValue] {
            self.pressure = Int(pressure.double!)
        }
        
        if let humidity = data[TempretureDetailsResponseParameters.Humidity.rawValue] {
            self.humidity = humidity.double
        }
        
        if let temperatureMinimum = data[TempretureDetailsResponseParameters.TempretureMinimum.rawValue] {
            self.temperatureMinimum = temperatureMinimum.double
        }
        
        if let temperatureMaximum = data[TempretureDetailsResponseParameters.TempretureMaximum.rawValue] {
            self.temperatureMaximum = temperatureMaximum.double
        }
        
    }
    
    
    /// get methods to the model parameters
    
    internal func getTemperature() -> Double {
        return self.temperature
    }
    
    internal func getPressure() -> Int {
        return self.pressure
    }
    
    internal func getHumidity() -> Double {
        return self.humidity
    }
    
    internal func getTemperatureMinimum() -> Double {
        return self.temperatureMinimum
    }
    
    internal func getTemperatureMaximum() -> Double {
        return self.temperatureMaximum
    }
    
}

