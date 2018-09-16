//
//  BaseModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel {

    
    /// get error code and check if it's internet connection error
    ///
    /// - Parameter error:  Error
    /// - Returns:          String
    internal func getErrorMessage(error : Error) -> String {
        
        let manager = ErrorManager()
        let errorMessage = manager.errorKeyForServerMessage(error: error)
        
        return errorMessage
    }
    
    /// handle the faliure state in case of not receiving response from the server or internet connection error
    ///
    /// - Parameters:
    ///   - onSuccess: Block
    ///   - onFaliure: Block
    internal func manageFaliureStateOfLoadingTheDataFromServer<T: BaseResponse>(onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        DatabaseManager.shared.getTableData(elementTable: DatabaseTable.Today, onSuccess: { (presavedData: String) in
            
            let dataParsed = JSON(parseJSON: presavedData)
            if let dataParsed = dataParsed.dictionary {
                
                let finalResponse = T(data: dataParsed)
                onSuccess(finalResponse)
                
            } else {
                
                onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            }
            
        }, onFaliure: { (error: String) in
            
            onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            
        })
    }
}
