//
//  ErrorManager.swift
//  MakersFair
//
//  Copyright © 2017 Asmaa Mostafa. All rights reserved.
//

import Foundation

class ErrorManager {
    
    private let networkCodes = [-1001, -1003, -1004, -1005, -1009, -1014, -1016, 500]
    
    
    /// Get the error code for the received error from URL request
    ///
    /// - Parameter error:  Error
    /// - Returns:          String
    internal func messageFor(error: Error) -> String {
        
        if isNetworkError(error: error) == true {
            return "noInternet"
        }
        return "\((error as NSError).code)"
    }
    
    
    /// check if the received error is a network connection error
    ///
    /// - Parameter error:  Error
    /// - Returns:          Bool
    internal func isNetworkError(error: Error) -> Bool {
        return networkCodes.contains((error as NSError).code)
    }
    
    
    /// get error code and check if it's internet connection error
    ///
    /// - Parameter error:  Error
    /// - Returns:          String
    static func getErrorMessage(error: Error) -> String {
        
        let manager = ErrorManager()
        let errorMessage = manager.messageFor(error: error)
        
        return errorMessage
    }
    
}
