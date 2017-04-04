//
//  WeatherDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum WeatherForecastForLocationResponseParameters: String  {
    case    City            =   "city"
    case    Code            =   "cod"
    case    Message         =   "message"
    case    NumberOfDays    =   "cnt"
    case    List            =   "list"
}

class WeatherForecastForLocationResponse: NSObject {
    
    private var cityData:           CurrentLocationDataModel!
    private var responseCode:       String!
    private var responseMessage:    Double!
    private var numberOfDays:       Int!
    private var listOfDays:         [WeatherForADayDataModel]!
    
    
    /// create instance from WeatherForecastForLocationResponse with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let cityData = data[WeatherForecastForLocationResponseParameters.City.rawValue] {
            self.cityData = CurrentLocationDataModel(data: cityData.dictionary!)
        }
        
        if let responseCode = data[WeatherForecastForLocationResponseParameters.Code.rawValue] {
            self.responseCode = responseCode.string
        }
        
        if let responseMessage = data[WeatherForecastForLocationResponseParameters.Message.rawValue] {
            self.responseMessage = responseMessage.double
        }
        
        if let numberOfDays = data[WeatherForecastForLocationResponseParameters.NumberOfDays.rawValue] {
            self.numberOfDays = numberOfDays.int
        }

        if let listOfDays = data[WeatherForecastForLocationResponseParameters.List.rawValue] {
            
            self.listOfDays = [WeatherForADayDataModel]()

            for element in listOfDays.array! {
                
                if let element = element.dictionary {

                    self.listOfDays.append( WeatherForADayDataModel(data: element)  )
                }
            }
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getCityData() -> CurrentLocationDataModel {
        return self.cityData
    }
    
    internal func getResponseCode() -> String {
        return self.responseCode
    }
    
    internal func getResponseMessage() -> Double {
        return self.responseMessage
    }
    
    internal func getNumberOfDays() -> Int {
        return self.numberOfDays
    }
    
    internal func getListOfDays() -> [WeatherForADayDataModel] {
        return self.listOfDays
    }
}
