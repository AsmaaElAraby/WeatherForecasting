//
//  CountryMapper.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class CountryHandler: NSObject {
    
    /// map the received country code to the country name
    ///
    /// - Parameter code: String
    /// - Returns:  String
    static func countryNameFor(code: String) -> String {
        
        return NSLocale(localeIdentifier: NSLocale.current.identifier).displayName(forKey: .countryCode, value: ((code.replacingOccurrences(of: " ", with: "").count > 0) ? code : (NSLocale.current.regionCode ?? "").lowercased())) ?? ""
    }
    
}
