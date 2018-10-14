//
//  DatabaseManager.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation
import Firebase

enum DatabaseTableName: String {
    case forcast = "forecast"
    case today = "today"
    case requests = "requests"
}

class DatabaseManager {
    
    private let basePath        = "WeatherForecasting"
    static  var shared          = DatabaseManager()
    private var database        = Database.database()
    private var databaseReference: DatabaseReference?
    
    private func initFirebase() {
        
        if databaseReference == nil {
            database.isPersistenceEnabled = true
            databaseReference = database.reference(withPath: basePath)
        }
    }
    
    internal func insert<T: Codable>(data: T, childName: String, to table: DatabaseTableName) {
        
        self.initFirebase()
        self.databaseReference?.child(table.rawValue).child(childName).updateChildValues(data.dictionary)
    }
    
    internal func update<T: Codable>(data: T, to table: DatabaseTableName) {
    
        self.databaseReference?.child(table.rawValue).setValue(data.dictionary)
    }
    
    internal func readDatafrom(table: DatabaseTableName, with childName: String, onSuccess: @escaping (_ response: String) -> Void, onFaliure: @escaping (_ error: String) -> Void) {
    
            self.initFirebase()
        
            self.databaseReference?.child(table.rawValue).child(childName).observe(.value, with: { snapshot in
                
                guard let value = snapshot.value as? [String: Any]  else {
                    onFaliure("generalErrorLoadingData")
                    return
                }
                do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    onSuccess(String(data: jsonData, encoding: .utf8) ?? "")
                } catch let error {
                    debugPrint(error)
                    onFaliure("generalErrorLoadingData")
                }
            })
        }
    
}
