//
//  TodayModel.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class TodayModel: BaseModel {
    
    
    /// load the waether data for today
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getTodayWeatherDataForLocationRequest<T: Codable>(request: WeatherForecastRequest, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        var childName = "\(Double(round(100 * (currentLocation?.lat)!)/100)),\(Double(round(100 * (currentLocation?.lon)!)/100))"
        childName = childName.replacingOccurrences(of: ".", with: ",")

        loadDataForRequest(url: AppURLs.TodayForecast.appending(request.description).appending(""), cachingTableName: .today, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
    }
    
}
