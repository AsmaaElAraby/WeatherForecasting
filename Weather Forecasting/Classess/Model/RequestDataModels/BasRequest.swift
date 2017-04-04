//
//  BasRequest.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BasRequest: NSObject {

    internal func asJSONDictionary() -> [String : Any] {
        return [String : Any]()
    }
    
    /// get the current object data as a dictionary
    ///
    /// - Returns:  [String : Any]
    internal func asString() -> String {
        
        var requestParametersAsString = ""
        for element in self.asJSONDictionary() {
            
            if requestParametersAsString != "" {
                requestParametersAsString += "&"
            }
            requestParametersAsString += "\(element.key)=\(element.value)"
        }
        
        return requestParametersAsString
    }
}
