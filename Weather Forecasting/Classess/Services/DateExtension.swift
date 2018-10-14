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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).capitalized
    }
    
    
    /// convert date of time stamp to day of the week
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  String?
    static func toWeekDay(timeInterval: TimeInterval) -> String? {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        return date.dayOfTheWeek()
    }
    
    /// convert date of time stamp to hour of the day
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  String?
    static func toHourMinutes(timeInterval: TimeInterval) -> String? {
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: date)
        
        return timeString
    }
    
    /// convert date of time stamp to hour of the day
    ///
    /// - Parameter timeInterval: TimeInterval
    /// - Returns:  String?
    static func isDay(timeInterval: TimeInterval) -> Bool {

        let date     = Date(timeIntervalSince1970: timeInterval)
        let calendar = Calendar.current
        let hour     = calendar.component(.hour, from: date)

        if 3 < hour, hour < 16 {
            return true
        }
        
        return false
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
