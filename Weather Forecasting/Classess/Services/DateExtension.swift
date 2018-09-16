//
//  DateExtension.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

extension Date {
    
    
    /// convert date to day of the week
    ///
    /// - Returns: String
    func dayOfTheWeek() -> String? {
        let weekdays = ["Sunday",
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Satudrday"]
        
        let calendar = Calendar.current
        let components = calendar.component(.weekday, from: self)
        return weekdays[components - 1]
    }
    
    
    /// convert date of time stamp to day of the week
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  String?
    static func timeStampToDayOfTheWeek(timeInterval: TimeInterval) -> String? {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        return date.dayOfTheWeek()
    }
}
