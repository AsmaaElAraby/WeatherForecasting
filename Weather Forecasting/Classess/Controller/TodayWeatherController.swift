//
//  TodayWeatherController.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

protocol TodayWeatherDelegate: RequestDelegate {
}

class TodayWeatherController: BaseController {
    
    /// load the waether forecast data for today and the next 7 days for the received loaction
    /// Then update the view with the recived data
    ///
    /// - Parameters:
    ///   - request:    WeatherRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func loadTodayWeatherForCurrentLocation() {
        
        self.delegate?.willLoad()
        
        LocationManager.shared.location = { (_ location: (latitude: Double, longitude: Double)?, _ error: String?) in
            
            guard (error == nil || error == "") && (error?.count == nil || error?.count == 0) else {
                
                self.delegate?.didFailWith(message: NSLocalizedString(error ?? "", comment: ""))
                return
            }
            
            // init a request with the user current location and the required number of days
            let request = WeatherRequest(latitude: location?.latitude ?? 0.0, longitude: location?.longitude  ?? 0.0)
            
            // connect to the server to load the reqired weather data
            let model = WeatherForecastModel()
            model.getTodayForecastFor(request: request, onSuccess: { (response: TodayWeatherForLocationResponse) in
                
                // send the received data to the delegate if it has one
                if self.delegate == nil {
                    
                    fatalError("You forget to set the controller delegate")
                } else {
                    
                    self.delegate?.didLoad(data: response)
                }
                
            }) { (error) in
                
                // server error or internet connection error
                self.delegate?.didFailWith(message: NSLocalizedString(error, comment: ""))
            }
        }

    }
    
}
