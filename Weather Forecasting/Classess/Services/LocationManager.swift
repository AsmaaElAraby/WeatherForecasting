//
//  LocationManager.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLocation

class LocationManager: NSObject {

    static let shared = LocationManager()
    
    
    /// load the user current location using GPS/Internet
    ///
    /// - Parameters:
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func getCurrentLocation(onSuccess : @escaping (_ latitude: Double, _ longitude: Double) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        self.getUserCurrentLocationWithAccuracy(accuracy: Accuracy.city, onSuccess: { (_ latitude: Double, _ longitude: Double) in
            
            onSuccess(latitude, longitude)
        }) { (error: String) in
            
            onFaliure(error)
        }
    }
    
    
    
    /// call an API that gets the user current location using GSP and in case it fails call it recursivly to load it using the internet
    ///
    /// - Parameters:
    ///   - accuracy:   Accuracy
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    private func getUserCurrentLocationWithAccuracy(accuracy: Accuracy, onSuccess : @escaping (_ latitude: Double, _ longitude: Double) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        // get the user current location with the accuracy of city static on this level of the app
        Location.getLocation(accuracy: accuracy, frequency: Frequency.oneShot, success: { (request: LocationRequest, location: CLLocation) -> (Void) in
            
            // if the received location is empty call the same method but loading it over the internet not from the GPS (it's a hack to load the user location)
             if location.coordinate.latitude != 0 && location.coordinate.longitude != 0 {
                
                onSuccess(location.coordinate.latitude, location.coordinate.longitude)
            } else {
                
                self.getUserCurrentLocationWithAccuracy(accuracy: Accuracy.IPScan(IPService.init(.smartIP)), onSuccess: onSuccess, onFaliure: onFaliure)
            }
            
        }) { (request: LocationRequest, location: CLLocation?, error: Error) -> (Void) in
            // if couldn't get the user current location try to load it without GPS
        
            self.getUserCurrentLocationWithAccuracy(accuracy: Accuracy.IPScan(IPService.init(.smartIP)), onSuccess: onSuccess, onFaliure: onFaliure)
        }
    }

}
