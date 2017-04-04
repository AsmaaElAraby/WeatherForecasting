//
//  BaseModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    
    /// get error code and check if it's internet connection error
    ///
    /// - Parameter error:  Error
    /// - Returns:          String
    internal func getErrorMessage(error : Error) -> String {
        
        let manager = ErrorManager()
        let errorMessage = manager.errorKeyForServerMessage(error: error)
        
        return errorMessage
    }
}
