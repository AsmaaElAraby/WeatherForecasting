//
//  DateExtension.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

extension Date {
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
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
    
    /// convert date of time stamp to hour of the day
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  String?
    static func timeStampToDayHour(timeInterval: TimeInterval) -> String? {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: date)
        
        return timeString
    }
    
    
    
    /// check if the received date is today
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  Bool
    static func isToday(timeInterval: TimeInterval) -> Bool {
        
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return calendar.isDateInToday(date)
    }
    
}
