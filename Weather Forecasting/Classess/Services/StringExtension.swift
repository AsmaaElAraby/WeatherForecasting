//
//  StringExtension.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
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
                substring(with: sInd..<eInd)
            }
        }
    }
}
