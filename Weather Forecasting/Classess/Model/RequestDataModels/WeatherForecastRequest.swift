//
//  WeatherForecastRequest.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

enum WeatherForecastRequestParameters :String {
    case    Latitude        =   "lat"
    case    Longitude       =   "lon"
    case    NumberOfDays    =   "cnt"
    case    AppId           =   "appid"
}

class WeatherForecastRequest: BasRequest {

    private var latitude:       Double!
    private var longitude:      Double!
    private var NumberOfDays:   String!

    
    /// init the request with the user current location and number of days should be loaded
    ///
    /// - Parameters:
    ///   - latitude:       Double
    ///   - longitude:      Double
    ///   - NumberOfDays:   String
    init(latitude: Double, longitude: Double, NumberOfDays: String = "") {
        
        self.latitude       = latitude
        self.longitude      = longitude
        self.NumberOfDays   = NumberOfDays
    }

    
    /// get the current object data as a dictionary
    ///
    /// - Returns:  [String : Any]
    internal override func asJSONDictionary() -> [String : Any] {
        
        if self.NumberOfDays != nil && self.NumberOfDays != "" {
            
            return [WeatherForecastRequestParameters.Latitude.rawValue      :   self.latitude,
                    WeatherForecastRequestParameters.Longitude.rawValue     :   self.longitude,
                    WeatherForecastRequestParameters.NumberOfDays.rawValue  :   self.NumberOfDays,
                    WeatherForecastRequestParameters.AppId.rawValue         :   WeatherMapKey.AppId.rawValue]
        }
        
        return [WeatherForecastRequestParameters.Latitude.rawValue      :   self.latitude,
                WeatherForecastRequestParameters.Longitude.rawValue     :   self.longitude,
                WeatherForecastRequestParameters.AppId.rawValue         :   WeatherMapKey.AppId.rawValue]
    }
    
}
