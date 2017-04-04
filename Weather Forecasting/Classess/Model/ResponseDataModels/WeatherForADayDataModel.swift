//
//  WeatherForecastDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum WeatherForADayResponseParameters: String  {
    case    Date          =   "dt"
    case    Temperature =   "temp"
    case    Pressure    =   "pressure"
    case    Humidity    =   "humidity"
    case    Weather     =   "weather"
    case    Speed       =   "speed"
    case    Degree      =   "deg"
    case    Clouds      =   "clouds"
}

class WeatherForADayDataModel: NSObject {
    
    private var dateTimeStamp:  Int!
    private var dateDay:        String!
    private var temperature:    TemperatureDataModel!
    private var pressure:       Double!
    private var humidity:       Double!
    private var weather:        [WeatherStateDataModel]!
    private var speed:          Double!
    private var degree:         Double!
    private var clouds:         Double!
    
    
    /// create instance from WeatherForADayDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let dateTimeStamp = data[WeatherForADayResponseParameters.Date.rawValue] {
            self.dateTimeStamp = dateTimeStamp.int
            self.dateDay = Date.timeStampToDayOfTheWeek(timeInterval: Double(self.dateTimeStamp))
        }
        
        if let temperature = data[WeatherForADayResponseParameters.Temperature.rawValue] {
            if let temperature = temperature.dictionary {
                
                self.temperature = TemperatureDataModel(data: temperature)
            }
        }
        
        if let pressure = data[WeatherForADayResponseParameters.Pressure.rawValue] {
            self.pressure = pressure.double
        }
        
        if let humidity = data[WeatherForADayResponseParameters.Humidity.rawValue] {
            self.humidity = humidity.double
        }
        
        if let weather = data[WeatherForADayResponseParameters.Weather.rawValue] {
            
            self.weather = [WeatherStateDataModel]()
            
            for element in weather.array! {
                if let element = element.dictionary {
                    
                    self.weather.append( WeatherStateDataModel(data: element) )
                }
            }
        }
        
        if let speed = data[WeatherForADayResponseParameters.Speed.rawValue] {
            self.speed = speed.double
        }
        
        if let degree = data[WeatherForADayResponseParameters.Degree.rawValue] {
            self.degree = degree.double
        }
        
        if let clouds = data[WeatherForADayResponseParameters.Clouds.rawValue] {
            self.clouds = clouds.double
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getDateTimeStamp() -> Int {
        return self.dateTimeStamp
    }
    
    internal func getDateDay() -> String {
        return self.dateDay
    }
    
    internal func getTemperature() -> TemperatureDataModel {
        return self.temperature
    }
    
    internal func getPressure() -> Double {
        return self.pressure
    }
    
    internal func getHumidity() -> Double {
        return self.humidity
    }
    
    internal func getWeather() -> [WeatherStateDataModel] {
        return self.weather
    }
    
    internal func getSpeed() -> Double {
        return self.speed
    }
    
    internal func getDegree() -> Double {
        return self.degree
    }
    
    internal func getClouds() -> Double {
        return self.clouds
    }
}
