//
//  WeatherStateMapper.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class WeatherStateMapper: NSObject {

    /// map the weather state recived from the server with the current images in the app
    ///
    /// - Parameter state: String
    /// - Returns:  String
    static func getWeatherStateImageTitle(state: String) -> String {
        
        if state.lowercased().contains(WeatherStateImageTitles.Sunny.rawValue) {
            
            return "ForcastSun"
            
        } else if state.lowercased().contains(WeatherStateImageTitles.Windy.rawValue) {
            
            return "ForcastWind"
            
        } else if state.lowercased().contains(WeatherStateImageTitles.Rain.rawValue) {
            
            return "ForcastCR"
            
        } else if state.lowercased().contains(WeatherStateImageTitles.Lightning.rawValue) {
            
            return "ForcastCL"
            
        } else if state.lowercased().contains(WeatherStateImageTitles.Cloudy.rawValue) {
            
            return "ForcastCS"
            
        } else {
            
            return ""
        }
    }
}
