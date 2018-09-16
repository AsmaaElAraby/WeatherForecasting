//
//  BaseModel.swift
//  Weather Forecasting
//
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
    
    
    
    func loadDataForRequest<T: Codable>(url: String, cachingTableName: DatabaseTableName, childName: String, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        APIManager.shared.requestDataWithGetMethod(url: url,  onSuccess: { (response: String?) in
            
            if response != nil {

                if let finalResponse = T.decode(json: response!, asA: T.self) {

                    DatabaseManager.shared.insert(data: finalResponse, childName: childName, to: cachingTableName)
                    onSuccess(finalResponse)

                } else {

                    onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
                }
            } else {

            self.loadCachedData(dataType: T.self, cachingTableName: cachingTableName, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
            }
        
        }) { (error: Error) in
            
            onFaliure(self.getErrorMessage(error: error))
        }
    }
    
    
    /// handle the faliure state in case of not receiving response from the server or internet connection error
    ///
    /// - Parameters:
    ///   - onSuccess: Block
    ///   - onFaliure: Block
    internal func loadCachedData<T: Codable>(dataType: T.Type, cachingTableName: DatabaseTableName, childName: String, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        DatabaseManager.shared.read(dataType: dataType.self, childName: childName, from: cachingTableName, onSuccess: { (presavedData) in
            
            if let finalResponse = T.decode(json: presavedData.description, asA: T.self) {
                
                onSuccess(finalResponse)
                
            } else {
                
                onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            }
            
        }, onFaliure: { (error: String) in
            
            onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
            
        })
    }
}
