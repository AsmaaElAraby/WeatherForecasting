//
//  TodayWeatherController.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

protocol TodayWeatherDelegate {
    func didLoadTodayWeatherData(data: TodayWeatherForLocationResponse)
    func didFail(message: String)
}

class TodayWeatherController: BaseController {
    
    private var delegate: TodayWeatherDelegate!
    
    
    /// init the controller with it's parent view controller
    ///
    /// - Parameter viewController: UIViewController
    init(viewController: UIViewController) {
        
        super.init()
        self.viewController = viewController
    }
    
    
    /// set the controller delegate
    ///
    /// - Parameter delegate:   TodayWeatherDelegate
    internal func setDelegate(delegate: TodayWeatherDelegate) {
        self.delegate = delegate
    }
    
    
    /// load the waether forecast data for today and the next 7 days for the received loaction
    /// Then update the view with the recived data
    ///
    /// - Parameters:
    ///   - request:    WeatherForecastRequest
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func loadTodayDataForCurrentLocation() {
        
        
        // display a loading indicator view
        let view = AndicatingView()
        view.startAnimating(view: self.viewController.view)
        
        
        // load the user location first
        LocationManager.shared.currentLocation(onSuccess: { (latitude: Double, longitude: Double) in
            
            
            // init a request with the user current location and the required number of days
            let request = WeatherForecastRequest(latitude: latitude, longitude: longitude)
            
            
            // connect to the server to load the reqired weather data
            let model = TodayModel()
            model.getTodayWeatherDataForLocationRequest(request: request, onSuccess: { (response: TodayWeatherForLocationResponse) in
                
                
                // send the received data to the delegate if it has one
                view.stopAnimating()
                
                if self.delegate == nil {
                    
                    fatalError("You forget to set the controller delegate")
                } else {
                    
                    self.delegate.didLoadTodayWeatherData(data: response)
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
