//
//  BaseModel.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import Alamofire

class BaseModel {
    
    func loadDataFor<T: Codable>(request: RequestProvider, cachingTableName: DatabaseTableName, childName: String, onSuccess : @escaping (_ response: T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        APIManager.shared.fetchDataFor(request: request, onSuccess: { (response: String?) in
            
            if response != nil {

                if let parsedResponse = T.decode(json: response!, asA: T.self) {

                    DatabaseManager.shared.insert(data: parsedResponse, childName: childName, to: cachingTableName)
                    onSuccess(parsedResponse)

                } else {

                    onFaliure(NSLocalizedString("generalErrorLoadingData", comment: ""))
                }
            } else {

                self.loadCachedDataWith(dataType: T.self, tableName: cachingTableName, childName: childName, onSuccess: onSuccess, onFaliure: onFaliure)
            }
        
        }) { (error: Error) in
            
            onFaliure(ErrorManager.getErrorMessage(error: error))
        }
    }
    
    /// handle the faliure state in case of not receiving response from the server or internet connection error
    ///
    /// - Parameters:
    ///   - onSuccess: Block
    ///   - onFaliure: Block
    internal func loadCachedDataWith<T: Codable>(dataType: T.Type, tableName: DatabaseTableName, childName: String, onSuccess : @escaping (_ response: T) -> Void, onFaliure: @escaping (_ error: String) -> Void) {
        
        DatabaseManager.shared.readDatafrom(table: tableName, with: childName, onSuccess: { (presavedData) in
            
            if let parsedData = T.decode(json: presavedData.description, asA: T.self) {
                
                onSuccess(parsedData)
                
            } else {
                
                onFaliure(NSLocalizedString("generalErrorLoadingData", comment: ""))
            }
            
        }, onFaliure: { _ in
            
            onFaliure(NSLocalizedString("generalErrorLoadingData", comment: ""))
            
        })
    }
    
    internal func dbChildName() -> String? {
        
        guard let currentLocation = currentLocation else {
            return nil
        }
        
        var childName = "\(Double(round(100 * currentLocation.latitude)/100)),\(Double(round(100 * currentLocation.longitude)/100))"
        childName = childName.replacingOccurrences(of: ".", with: ",")
        
        return childName
    }
    
}
