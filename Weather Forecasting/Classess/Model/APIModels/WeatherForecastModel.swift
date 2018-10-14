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

        var childName = "\(Double(round(100 * (currentLocation?.lat)!)/100)),\(Double(round(100 * (currentLocation?.lon)!)/100))"
        childName = childName.replacingOccurrences(of: ".", with: ",")

        loadDataForRequest(url: AppURLs.DailyForecast.appending(request.description).appending(""), cachingTableName: .forcast, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
    }
    
}
