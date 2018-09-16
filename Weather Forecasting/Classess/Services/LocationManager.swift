//
//  LocationManager.swift
//  Weather Forecasting
//
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftLocation

class LocationManager {
    
    static let shared = LocationManager()
    
    
    /// load the user current location using GPS/Internet
    ///
    /// - Parameters:
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    internal func currentLocation(onSuccess : @escaping (_ latitude: Double, _ longitude: Double) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        currentLocationWith(accuracy: Accuracy.city, onSuccess: { (_ latitude: Double, _ longitude: Double) in
            
            onSuccess(latitude, longitude)
        }) { (error: String) in
            
            onFaliure(error)
        }
    }
    
    
    
    /// call an API that gets the user current location using GSP and in case it fails try to load it throw the internet
    ///
    /// - Parameters:
    ///   - accuracy:   Accuracy
    ///   - onSuccess:  Block
    ///   - onFaliure:  Block
    private func currentLocationWith(accuracy: Accuracy, onSuccess : @escaping (_ latitude: Double, _ longitude: Double) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        // get the user current location with the accuracy of city static on this level of the app
        Locator.currentPosition(accuracy: .city, onSuccess: { (location) -> (Void) in
            
            // if the received location is empty call the same method but loading it over the internet not from the GPS (it's a hack to load the user location)
            (location.coordinate.latitude != 0 && location.coordinate.longitude != 0) ? onSuccess(location.coordinate.latitude, location.coordinate.longitude) : self.currentLocationWithIpAddress(onSuccess: onSuccess, onFaliure: onFaliure)
            
        }) { (err, last) -> (Void) in
            
            // if couldn't get the user current location try to load it without GPS
            self.currentLocationWithIpAddress(onSuccess: onSuccess, onFaliure: onFaliure)
        }
    }
    
    
    
    /// loading user location throw ip address via free service
    ///
    /// - Parameters:
    ///   - onSuccess: Block
    ///   - onFaliure: Block
    private func currentLocationWithIpAddress(onSuccess : @escaping (_ latitude: Double, _ longitude: Double) -> Void, onFaliure : @escaping (_ error : String) -> Void) {
        
        Locator.currentPosition(usingIP: .freeGeoIP, onSuccess: { location in
            (location.coordinate.latitude != 0 && location.coordinate.longitude != 0) ? onSuccess(location.coordinate.latitude, location.coordinate.longitude) : onFaliure("locationLoadingError")
        }) { error, _ in
            onFaliure(error.localizedDescription)
        }
    }
    
}
