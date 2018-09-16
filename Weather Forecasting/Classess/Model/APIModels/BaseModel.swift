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
    
    
    
    func loadDataForRequest<T: Codable>(url: String, cachingTableName: DatabaseTableName, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        APIManager.shared.requestDataWithGetMethod(url: url,  onSuccess: { (response: String?) in
            
            if response != nil {
                
                if let finalResponse = T.decode(json: response!, asA: T.self) {
                    
                    DatabaseManager.shared.insert(data: finalResponse, to: cachingTableName)
                    onSuccess(finalResponse)
                    
                } else {
                    
                    onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
                }
            } else {
                
                //                self.loadCachedData(dataType: T.self, from: .today, for: request, onSuccess: onSuccess, onFaliure: onFaliure)
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
    //    internal func manageFaliureStateOfLoadingTheDataFromServer<T: Codable>(dataType: T, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
    //
    //        DatabaseManager.shared.read(dataType: dataType.self, from: .today, onSuccess: { (presavedData: [TodayWeatherForLocationResponse]) in
    //
    ////            let dataParsed = JSON(parseJSON: presavedData)
    //            if let finalResponse = T.decode(json: presavedData.description, asA: T.self) {
    //
    //                onSuccess(finalResponse)
    //
    //            } else {
    //
    //                onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
    //            }
    //
    //        }, onFaliure: { (error: String) in
    //
    //            onFaliure(LocalizationManager.shared.localizeStringWith(key: "generalErrorLoadingData"))
    //
    //        })
    //    }
}
