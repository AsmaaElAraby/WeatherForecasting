//
//  DatabaseManager.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import Firebase

class DatabaseManager {

    private let DatabasePath    = "WeatherForecasting"
    static  var shared          = DatabaseManager()
    private var database        = Database.database()
    private var databaseReference: DatabaseReference?

    private func initFirebase() {

        if databaseReference == nil {
            database.isPersistenceEnabled = true
            databaseReference = database.reference(withPath: DatabasePath)
        }
    }
    
    internal func setUpdateTableData(elementTable: DatabaseTable, elementValue: String) {
        
        self.initFirebase()
        self.databaseReference?.child(elementTable.rawValue).setValue(elementValue)
    }

    internal func getTableData(elementTable: DatabaseTable, onSuccess : @escaping (_ response : String) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        self.databaseReference?.child(elementTable.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let valueAsString = snapshot.value as? String {
                
                onSuccess(valueAsString)
            }
            
            onFaliure("generalErrorLoadingData")
            
        }) { (error) in
            
            onFaliure(error.localizedDescription)
        }

    }
}

enum DatabaseTable: String {
    case Forcast = "forecast"
    case Today = "today"
}

enum DatabaseTableId: String {
    case ForcastId = "forecast_id"
    case TodayId = "today_id"
}


