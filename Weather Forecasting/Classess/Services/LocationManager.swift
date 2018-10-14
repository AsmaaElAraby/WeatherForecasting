//
//  LocationManager.swift
//  Weather Forecasting
//
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

enum LocationURLs: String {
    
    case base = "http://ip-api.com/json"
    
    var path: String {
        return self.rawValue
    }
    
}

typealias Location = (latitude: Double, longitude: Double)

class LocationManager: NSObject {
    
    static var shared: LocationManager {
        struct Static {
            static let instance : LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    lazy var locationManager: CLLocationManager = {

        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        return locationManager
    }()
    
    var location: ((_ location: (latitude: Double, longitude: Double)?, _ error: String?) -> Void)?
    
    func startLocationUpdates() {
        
        checkLocationPermission()
    }
    
    private func checkLocationPermission() {
        
        if CLLocationManager.locationServicesEnabled() {
        
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                // If status has not yet been determied, ask for authorization
                locationManager.requestWhenInUseAuthorization()

            case .authorizedWhenInUse:
                // If authorized when in use
                locationManager.requestLocation()

            case .authorizedAlways:
                // If always authorized
                locationManager.requestLocation()

            case .restricted:
                // If restricted by e.g. parental controls. User can't enable Location Services
                return
            case .denied:
                // If user denied your app access to Location Services, but can grant access from Settings.app
                openSettings()
            }
            
        } else {
            
            openSettings()
        }
    }
    
    private func openSettings() {
        UIAlertController().settingsAlertWith(title: NSLocalizedString("locationState", comment: ""), message: NSLocalizedString("requestEnableLocation", comment: "")) { [weak self] (_) in
            self?.location?(nil, "requestEnableLocation")
        }
    }
    
}

extension LocationManager {
    
    /// loading user location throw ip address via free service
    ///
    /// - Parameter completion: (currentLocation, errorMessage)
    fileprivate func getIpLocation(completion: @escaping(Location?, String?) -> Void) {
        
        APIManager.shared.fetchDataFor(request: RequestProvider.get(url: LocationURLs.base.rawValue, params: nil), onSuccess: { (reuslt) in
            
            guard let finalResponse = LocationCoordinatesDataModel.decode(json: reuslt!, asA: LocationCoordinatesDataModel.self),
            finalResponse.latitude != nil, finalResponse.longitude != nil,
            finalResponse.latitude! > 0.0 && finalResponse.longitude! > 0.0 else {
                
                completion(nil, "locationLoadingError")
                return
            }
            
            completion(Location(finalResponse.latitude!, finalResponse.longitude!), nil)
            
        }) { (error) in
            
            completion(nil, ErrorManager.getErrorMessage(error: error))
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse:
            // If authorized when in use
            manager.requestLocation()

        case .authorizedAlways:
            // If always authorized
            manager.requestLocation()

        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var latitude = 0.0
        var longitude = 0.0
        guard let lastLocation: CLLocation = locations.last else {
            return
        }
        latitude = lastLocation.coordinate.latitude
        longitude = lastLocation.coordinate.longitude
        
        debugPrint("user latitude = \(lastLocation.coordinate.latitude)")
        debugPrint("user longitude = \(lastLocation.coordinate.longitude)")

        locationManager.stopUpdatingLocation()
        
        guard latitude != currentLocation?.latitude && longitude != currentLocation?.longitude else {
            return
        }
        
        currentLocation = (latitude, longitude)
        location?(Location(latitude, longitude), nil)
        
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        debugPrint("Error \(error)")
        locationManager.stopUpdatingLocation()
        
        getIpLocation { [unowned self] (locationDic, error) in

            guard let locationDic = locationDic else {
                self.location?(nil, error)
                return
            }
            
            currentLocation = (locationDic.latitude, locationDic.longitude)
            self.location?(locationDic, error)
            
            return
        }
    }
    
}
