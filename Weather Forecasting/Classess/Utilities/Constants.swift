//
//  Constants.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

enum StoryBoardes: String {
    
    case weatherInformation = "WeatherInformation"
    
    /// load instance from storyboard
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    /// load view controller from storyboard instance
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        
        let stryboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let viewController = instance.instantiateViewController(withIdentifier: stryboardID) as? T else {
            fatalError("Double check for the requested viewController of type \(viewControllerClass) in storyboard with id \(stryboardID)")
        }
        
        return viewController
    }
    
}

enum ViewControllerID: String {
    
    case viewController = ""
}

enum WeatherMap: String {
    
    case key = "427ffd1134a8e757ff6d93fb0cfbc8d9"
}

struct ApplicationColors {
    
    static let tabBarItemUnselectedColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    static let tabBarItemSelectedColor = UIColor(red: 47/255, green: 145/255, blue: 255/255, alpha: 1.0)
}

enum WeatherStateIds: Int {
    
    case clearSky       = 800
    case fewClouds      = 801
    case scatteredClouds    = 802
    case brokenClouds   = 803
    case lightRain      = 500
    case moderateRain   = 501
    case snow   = 600
    case showerRain = 502
    case thunderstorm   = 503
    case mist   = 701
    case fog    = 741
}

enum ScreenName {
    
    case today
    case forcast
}

var currentCityName: String?
var currentLocation: (latitude: Double, longitude: Double)?
let logoImageName = "Sun_Big"
