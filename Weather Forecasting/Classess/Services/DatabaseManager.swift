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
    
    internal func insert<T: Codable>(data: T, to table: DatabaseTableName) {
        
        self.initFirebase()
        if let id = data.dictionary["id"] as? Int, id > 0 {
            self.databaseReference?.child(table.rawValue).child("\(id)").updateChildValues(data.dictionary)
        } else {
            self.databaseReference?.child(table.rawValue).childByAutoId().setValue(data.dictionary)
        }
    }
    
    internal func update<T: Codable>(data: T, to table: DatabaseTableName) {
        
        self.databaseReference?.child(table.rawValue).setValue(data.dictionary)
    }
    
    //    internal func read<T: Codable>(dataType: T.Type, from table: DatabaseTableName, for lat: Double, _ long: Double, onSuccess : @escaping (_ response : T) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
    //
    //        self.initFirebase()
    //        self.databaseReference?.queryOrdered(byChild: "coord").observe(.value, with: { snapshot in
    //            var newItems: [TodayWeatherForLocationResponse] = []
    //            for child in snapshot.children {
    //                if let snapshot = child as? FIRDataSnapshot,
    //                    let groceryItem = TodayWeatherForLocationResponse(snapshot: snapshot) {
    //                    newItems.append(groceryItem)
    //                }
    //            }
    //
    //            self.items = newItems
    //            self.tableView.reloadData()
    //        })
    //
    //
    ////        self.databaseReference?.child(table.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
    ////
    //////            .queryEqual(toValue: LocationCoordinatesDataModel(latitude: lat, longitude: long).dictionary)
    ////
    //////            LocationCoordinatesDataModel(latitude: lat, longitude: long).dictionary
    ////
    //////            self.databaseReference?.child("coord")
    //////                .children(["23423lkj234", "20982lkjbba"])
    //////                .on('value', snapshot => snapshot.val())
    ////
    //////            if let valueAsString = snapshot.value as? [T] {
    //////
    //////                onSuccess(valueAsString)
    //////            }
    ////
    ////            onFaliure("generalErrorLoadingData")
    ////
    ////        }) { (error) in
    ////
    ////            onFaliure(error.localizedDescription)
    ////        }
    //
    //    }
}
