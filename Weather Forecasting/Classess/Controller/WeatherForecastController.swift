//
//  WeatherForecastController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

protocol WeatherForecastDelegate {
    func didLoadWeatherForecastData(data: WeatherForecastForLocationResponse)
}

class WeatherForecastController: BaseController {

    private var delegate: WeatherForecastDelegate!
    
    
    /// init the controller with it's parent view controller
    ///
    /// - Parameter viewController: UIViewController
    init(viewController: UIViewController) {
        
        super.init()
        self.viewController = viewController
    }
    
    
    /// set the controller delegate
    ///
    /// - Parameter delegate:   WeatherForecastDelegate
    internal func setDelegate(delegate: WeatherForecastDelegate) {
        self.delegate = delegate
    }
    
    
    /// load the waether forecast data for today and the next 7 days for the received loaction
    /// Then update the view with the recived data
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func loadForecastDataForCurrentLocation() {
        
        
        // display a loading indicator view
        let view = AndicatingView()
        view.startAnimating(view: self.viewController.view)
        
        
        // load the user location first
        LocationManager.shared.currentLocation(onSuccess: { (latitude: Double, longitude: Double) in
            
            
            // init a request with the user current location and the required number of days
            let request = WeatherForecastRequest(latitude: latitude, longitude: longitude, numberOfDays: "7")
            
            
            // connect to the server to load the reqired weather data
            let model = WeatherForecastModel()
            model.getWeatherDataForLocationRequest(request: request, onSuccess: { (response: WeatherForecastForLocationResponse) in

                
                // send the received data to the delegate if it has one
                view.stopAnimating()
                
                if self.delegate == nil {
                 
                    fatalError("You forget to set the controller delegate")
                } else {
                    
                    self.delegate.didLoadWeatherForecastData(data: response)
                }
                
                
            }) { (error: String) in

                // server error or internet connection error
                view.stopAnimating()
                self.showErrorMessageAlert(message: error)
            }
            
        }) { (error: String) in

            // please open your GPS/Internet to be able to load your location and your data
            view.stopAnimating()
            self.showErrorMessageAlert(message: error)
        }
    }
    
}
