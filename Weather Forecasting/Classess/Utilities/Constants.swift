//
//  Constants.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

struct AppURLs {
    
    static let BaseURL  = "http://api.openweathermap.org/"
    static let DailyForecast    = BaseURL.appending("data/2.5/forecast?")
    static let TodayForecast    = BaseURL.appending("data/2.5/weather?")
}

enum StoryBoardes : String {
    
    case WeatherInformation = "WeatherInformation"
    
    /// load instance from storyboard
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    /// load view controller from storyboard instance
    func viewController <T: UIViewController>(viewControllerClass: T.Type) -> T {
        
        let stryboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: stryboardID) as! T
    }
}

enum ViewControllerID : String {
    
    case AuthonticationViewController = "AuthonticationViewController"
    case AuthonticationNavigationController = "AuthonticationNavigationController"
}

enum WeatherMapKey: String {
    
    case AppId = "427ffd1134a8e757ff6d93fb0cfbc8d9"
}

struct ApplicationColors {
    
    static let UnselectedTabbarItemColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    static let SelectedTabbarItemColor = UIColor(red:0.19, green:0.51, blue:0.98, alpha:1.0)
}

//struct Constants {

    var currentCityName: String?
    var currentLocation: (lat: Double, lon: Double)?
//}
