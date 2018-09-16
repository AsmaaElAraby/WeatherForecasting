//
//  StringExtension.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

extension String {
    
    
    /// get part of String
    ///
    /// - Parameters:
    ///   - start:  String
    ///   - to:     String
    /// - Returns:  String?
    func sliceFrom(start: String, to: String) -> String? {
        return (range(of: start)?.upperBound).flatMap { sInd in
            (range(of: to, range: sInd..<endIndex)?.lowerBound).map { eInd in
                String(self[sInd..<eInd])
            }
        }
    }
}
