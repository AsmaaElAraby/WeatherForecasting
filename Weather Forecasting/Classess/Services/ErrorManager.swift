//
//  ErrorManager.swift
//  MakersFair
//
//  Created by mac on 3/4/17.
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import UIKit

class ErrorManager {

    private let NetworkCodes = [-1001, -1003, -1004, -1005, -1009, -1014, -1016, 500]
    
    
    /// Get the error code for the received error from URL request
    ///
    /// - Parameter error:  Error
    /// - Returns:          String
    internal func errorKeyForServerMessage(error: Error) -> String {
        
        if self.isNetworkValidationError(error: error) == true {
            return "noInternet"
        }
        return "\((error as NSError).code)"
    }
    
    
    /// check if the received error is a network connection error
    ///
    /// - Parameter error:  Error
    /// - Returns:          Bool
    internal func isNetworkValidationError(error: Error) -> Bool {
        return NetworkCodes.contains((error as NSError).code)
    }
}
