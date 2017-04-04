//
//  TodayModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

class TodayModel: BaseModel {

    
    /// load the waether data for today
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getTodayWeatherDataForLocationRequest(request: WeatherForecastRequest, onSuccess : @escaping (_ response : TodayWeatherForLocationResponse) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        APIManager.shared.requestDataWithGetMethod(url: AppURLs.TodayForecast.appending(request.asString()).appending(""),  onSuccess: { (response: String?) in
            
            if response != nil {
                
                DatabaseManager.shared.setUpdateTableData(elementTable: DatabaseTable.Today, elementValue: response!)
                
                let dataParsed = JSON(parseJSON: response!)
                if let dataParsed = dataParsed.dictionary {
                    
                    let finalResponse = TodayWeatherForLocationResponse(data: dataParsed)
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
    internal func manageFaliureStateOfLoadingTheDataFromServer(onSuccess : @escaping (_ response : TodayWeatherForLocationResponse) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        DatabaseManager.shared.getTableData(elementTable: DatabaseTable.Today, onSuccess: { (presavedData: String) in
            
            let dataParsed = JSON(parseJSON: presavedData)
            if let dataParsed = dataParsed.dictionary {
                
                let finalResponse = TodayWeatherForLocationResponse(data: dataParsed)
                onSuccess(finalResponse)
                
            } else {
                
                onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            }
            
        }, onFaliure: { (error: String) in
            
            onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            
        })
    }
}
