//
//  WeatherStateMapper.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class WeatherHandler: NSObject {

    /// map the weather state recived from the server with the current images in the app
    ///
    /// - Parameters:
    ///   - screenName: ScreenName id for the requesting screen
    ///   - id: weather state id received from the server
    ///   - isDay: true if it is for a day time and false if it's for night time
    /// - Returns: Image name
    static func imageNameFor(screenName: ScreenName, weatherStateId id: Int, isDay: Bool) -> String {
        
        let dayPerioud = isDay ? "Day" : "Night"
        switch id {
        case WeatherStateIds.clearSky.rawValue:
            return screenName == .today ? "ClearSkyWeatherState\(dayPerioud)LabelTodayScreen" : "ClearSky\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.fewClouds.rawValue:
            return screenName == .today ? "FewCloudsWeatherState\(dayPerioud)LabelTodayScreen" : "FewClouds\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.brokenClouds.rawValue:
            return screenName == .today ? "BrokenCloudsWeatherState\(dayPerioud)LabelTodayScreen" : "BrokenClouds\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.scatteredClouds.rawValue:
            return screenName == .today ? "ScatteredCloudsWeatherState\(dayPerioud)LabelTodayScreen" : "ScatteredClouds\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.lightRain.rawValue, WeatherStateIds.moderateRain.rawValue:
            return screenName == .today ? "RainWeatherState\(dayPerioud)LabelTodayScreen" : "Rain\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.showerRain.rawValue:
            return screenName == .today ? "ShowerRainWeatherState\(dayPerioud)LabelTodayScreen" : "ShowerRain\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.mist.rawValue:
            return screenName == .today ? "MistWeatherState\(dayPerioud)LabelTodayScreen" : "Mist\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.snow.rawValue:
            return screenName == .today ? "SnowWeatherState\(dayPerioud)LabelTodayScreen" : "Snow\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.thunderstorm.rawValue:
            return screenName == .today ? "ThunderstormWeatherState\(dayPerioud)LabelTodayScreen" : "Thunderstorm\(dayPerioud)LabelForcastTableCell"
        case WeatherStateIds.fog.rawValue:
            return screenName == .today ? "MistWeatherState\(dayPerioud)LabelTodayScreen" : "Mist\(dayPerioud)LabelForcastTableCell"

        default:
            return ""
        }
    }
    
    
    /// Convert the wind degree to an equivallent direction of the wind
    ///
    /// - Parameter degree: Double
    /// - Returns:  String
    static func windDirectionFor(degree: Double) -> String {
        
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let degreeOfDirection = ((degree + 11.25)/22.5).truncatingRemainder(dividingBy: 16)
        let degreeOfDirectionAsInt = Int(degreeOfDirection)
        return directions[degreeOfDirectionAsInt]
    }
    
}
