//
//  WeatherForecastModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherForecastModel: BaseModel {

    
    /// load the waether forecast data
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getWeatherDataForLocationRequest(request: WeatherForecastRequest, onSuccess : @escaping (_ response : WeatherForecastForLocationResponse) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        APIManager.shared.requestDataWithGetMethod(url: AppURLs.DailyForecast.appending(request.asString()).appending(""),  onSuccess: { (response: String?) in
            
            if response != nil {
                
                DatabaseManager.shared.setUpdateTableData(elementTable: DatabaseTable.Forcast, elementValue: response!)

                let dataParsed = JSON(parseJSON: response!)
                if let dataParsed = dataParsed.dictionary {
                    
                    let finalResponse = WeatherForecastForLocationResponse(data: dataParsed)
                    onSuccess(finalResponse)
                    
                } else {
                    
                    onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
                }
            } else {
                
                self.manageFaliureStateOfLoadingTheDataFromServer(onSuccess: onSuccess, onFaliure: onFaliure)

            }

        }) { (error: Error) in
            
            onFaliure(self.getErrorMessage(error: error))
        }
    }
    
    
    
    /// handle the faliure state in case of not receiving response from the server or internet connection error
    ///
    /// - Parameters:
    ///   - onSuccess: Block
    ///   - onFaliure: Block
    private func manageFaliureStateOfLoadingTheDataFromServer(onSuccess : @escaping (_ response : WeatherForecastForLocationResponse) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        DatabaseManager.shared.getTableData(elementTable: DatabaseTable.Forcast, onSuccess: { (presavedData: String) in
            
            let dataParsed = JSON(parseJSON: presavedData)
            if let dataParsed = dataParsed.dictionary {
                
                let finalResponse = WeatherForecastForLocationResponse(data: dataParsed)
                onSuccess(finalResponse)
                
            } else {
                
                onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            }
            
        }, onFaliure: { (error: String) in
            
            onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            
        })
    }
}
