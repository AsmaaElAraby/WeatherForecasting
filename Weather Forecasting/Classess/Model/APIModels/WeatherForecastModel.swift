//
//  WeatherForecastModel.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class WeatherForecastModel: BaseModel {
    
    
    /// load the waether forecast data
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getWeatherDataForLocationRequest(request: WeatherForecastRequest, onSuccess : @escaping (_ response : WeatherForecastForLocationResponse) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        loadDataForRequest(url: AppURLs.DailyForecast.appending(request.description).appending(""), cachingTableName: .forcast, onSuccess: onSuccess, onFaliure: onFaliure)
    }
    
}
