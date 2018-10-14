//
//  WeatherForecastController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

protocol WeatherForecastDelegate: RequestDelegate {
}

class WeatherForecastController: BaseController {
    
    /// load the waether forecast data for today and the next 7 days for the received loaction
    /// Then update the view with the recived data
    ///
    /// - Parameters:
    ///   - request:    WeatherRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func loadForecastWeatherForCurrentLocation() {
        
        self.delegate?.willLoad()
        
        if currentLocation != nil {
            
            dailyForecastFor(latitude: currentLocation?.latitude ?? 0.0, longitude: currentLocation?.latitude ?? 0.0)
        } else {
         
            LocationManager.shared.location = { [unowned self] (_ location: (latitude: Double, longitude: Double)?, _ error: String?) in
                
                guard (error == nil || error == "") && (error?.count == nil || error?.count == 0) else {
                    
                    self.delegate?.didFailWith(message: NSLocalizedString(error ?? "", comment: ""))
                    return
                }
                
                self.dailyForecastFor(latitude: location?.latitude ?? 0.0, longitude: location?.latitude ?? 0.0)
            }
        }
    }
    
    func listOfSubDaysFrom(data: [WeatherForADayDataModel]) -> [[WeatherForADayDataModel]] {
        
        return WeatherForecastModel.listOfSubDaysFrom(data: data)
    }
    
    private func dailyForecastFor(latitude: Double, longitude: Double) {
        
        // init a request with the user current location and the required number of days
        let request = WeatherRequest(latitude: latitude, longitude: longitude)
        
        // connect to the server to load the reqired weather data
        let model = WeatherForecastModel()
        model.getDailyForecastFor(request: request, onSuccess: { (response: WeatherForecastForLocationResponse) in
            
            // send the received data to the delegate if it has one
            
            if self.delegate == nil {
                
                fatalError("You forget to set the controller delegate")
            } else {
                
                self.delegate?.didLoad(data: response)
            }
            
        }) { (error: String) in
            
            // server error or internet connection error
            self.delegate?.didFailWith(message: NSLocalizedString(error, comment: ""))
        }
    }
    
}
