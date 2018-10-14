//
//  WeatherForecastModel.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class WeatherForecastModel: BaseModel {
    
    
    /// load the waether data for today
    ///
    /// - Parameters:
    ///   - request:    WeatherRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getTodayForecastFor<T: Codable>(request: WeatherRequest, onSuccess: @escaping (_ response: T) -> Void, onFaliure: @escaping (_ error: String) -> Void) {
        
        // couldn't create child name means don't have location value so it should not continue
        guard let childName = dbChildName() else {
            onFaliure("")
            return
        }
        
        loadDataFor(request: RequestProvider.get(url: URLs.todayForecast.path, params: request.dictionary), cachingTableName: .today, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
    }
    
    
    /// load the waether forecast data
    ///
    /// - Parameters:
    ///   - request:    WeatherRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getDailyForecastFor(request: WeatherRequest, onSuccess: @escaping (_ response: WeatherForecastForLocationResponse) -> Void, onFaliure: @escaping (_ error: String) -> Void) {

        // couldn't create child name means don't have location value so it should not continue
        guard let childName = dbChildName() else {
            onFaliure("")
            return
        }
        
        loadDataFor(request: RequestProvider.get(url: URLs.dailyForecast.path, params: request.dictionary), cachingTableName: .forcast, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
    }
    
    static func listOfSubDaysFrom(data: [WeatherForADayDataModel]) -> [[WeatherForADayDataModel]] {
        
        var result = [[WeatherForADayDataModel]]()
        
        var firstDate = data[0].dateTimeStamp
        var elementsWithSameDate = [WeatherForADayDataModel]()
        elementsWithSameDate.append(data[0])
        
        for index in 1...data.count-1 {
            
            if Date(timeIntervalSince1970: TimeInterval(firstDate)).day != Date(timeIntervalSince1970: TimeInterval(data[index].dateTimeStamp)).day {
                
                if elementsWithSameDate.count > 0 {
                    result.append(elementsWithSameDate)
                    elementsWithSameDate = []
                }
            } else {
                elementsWithSameDate.append(data[index])
            }
            
            if index <= data.count - 1 {
                firstDate = data[index].dateTimeStamp
            }
        }
        
        return result
        
    }
    
}
