//
//  TodayWeatherForLocationResponse.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum TodayWeatherForLocationResponseParameters: String  {
    case    Coordinates =   "coord"
    case    Weather     =   "weather"
    case    Base        =   "base"
    case    Main        =   "main"
    case    Visibility  =   "visibility"
    case    Wind        =   "wind"
    case    Clouds      =   "clouds"
    case    Date        =   "dt"
    case    Sys         =   "sys"
    case    Id          =   "id"
    case    Name        =   "name"
    case    Code        =   "cod"
}

class TodayWeatherForLocationResponse: NSObject {
    
    private var coordinates:        LocationCoordinatesDataModel!
    private var weatherState:       [WeatherStateDataModel]!
    private var base:               String!
    private var tempretureDetails:  TempretureDetailsDataModel!
    private var visibility:         Int!
    private var wind:               WindDetailsDataModel!
    private var clouds:             CloudsDetailsDataModel!
    private var dateTimeStamp:      Int!
    private var dateDay:            String!
    private var sunDetails:         SunDetailsDataModel!
    private var elementId:          Int!
    private var name:               String!
    private var code:               Int!
    

    /// create instance from TodayWeatherForLocationResponse with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let coordinates = data[TodayWeatherForLocationResponseParameters.Coordinates.rawValue] {
            self.coordinates = LocationCoordinatesDataModel(data: coordinates.dictionary!)
        }
        
        if let weatherState = data[TodayWeatherForLocationResponseParameters.Weather.rawValue] {
            
            self.weatherState = [WeatherStateDataModel]()
            
            for element in weatherState.array! {
                
                if let element = element.dictionary {
                    
                    self.weatherState.append( WeatherStateDataModel(data: element)  )
                }
            }
        }

        if let base = data[TodayWeatherForLocationResponseParameters.Base.rawValue] {
            self.base = base.string
        }
        
        if let tempretureDetails = data[TodayWeatherForLocationResponseParameters.Main.rawValue] {
            self.tempretureDetails = TempretureDetailsDataModel(data: tempretureDetails.dictionary!)
        }
        
        if let visibility = data[TodayWeatherForLocationResponseParameters.Visibility.rawValue] {
            self.visibility = visibility.int
        }

        if let wind = data[TodayWeatherForLocationResponseParameters.Wind.rawValue] {
            self.wind = WindDetailsDataModel(data: wind.dictionary!)
        }
        
        if let clouds = data[TodayWeatherForLocationResponseParameters.Clouds.rawValue] {
            self.clouds = CloudsDetailsDataModel(data: clouds.dictionary!)
        }
        
        if let dateTimeStamp = data[TodayWeatherForLocationResponseParameters.Date.rawValue] {
            self.dateTimeStamp = dateTimeStamp.int
            self.dateDay = Date.timeStampToDayOfTheWeek(timeInterval: Double(self.dateTimeStamp))
        }
        
        if let sunDetails = data[TodayWeatherForLocationResponseParameters.Sys.rawValue] {
            self.sunDetails = SunDetailsDataModel(data: sunDetails.dictionary!)
        }
        
        if let elementId = data[TodayWeatherForLocationResponseParameters.Id.rawValue] {
            self.elementId = elementId.int
        }
        
        if let name = data[TodayWeatherForLocationResponseParameters.Name.rawValue] {
            self.name = name.string
        }
        
        if let code = data[TodayWeatherForLocationResponseParameters.Code.rawValue] {
            self.code = code.int
        }
        
    }
    
    
    /// get methods to the model parameters
    
    internal func getCoordinates() -> LocationCoordinatesDataModel {
        return self.coordinates
    }
    
    internal func getWeatherState() -> [WeatherStateDataModel] {
        return self.weatherState
    }
    
    internal func getBase() -> String {
        return self.base
    }
    
    internal func getTempretureDetails() -> TempretureDetailsDataModel {
        return self.tempretureDetails
    }
    
    internal func getVisibility() -> Int {
        return self.visibility
    }
    
    internal func getWind() -> WindDetailsDataModel {
        return self.wind
    }
    
    internal func getClouds() -> CloudsDetailsDataModel {
        return self.clouds
    }
    
    internal func getDateTimeStamp() -> Int {
        return self.dateTimeStamp
    }
    
    internal func getDateDay() -> String {
        return self.dateDay
    }
    
    internal func getSunDetails() -> SunDetailsDataModel {
        return self.sunDetails
    }
    
    internal func getElementId() -> Int {
        return self.elementId
    }
    
    internal func getName() -> String {
        return self.name
    }
    
    internal func getCode() -> Int {
        return self.code
    }
}
