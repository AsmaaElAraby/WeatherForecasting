//
//  LocationCoordinatesDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum LocationCoordinatesResponseParameters: String  {
    case    Latitude    =   "lat"
    case    Longitude   =   "lon"
}

class LocationCoordinatesDataModel: NSObject {
    
    private var latitude:   Double!
    private var longitude:  Double!
    
    
    /// create instance from TemperatureDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : Any]
    init(data: [String : JSON]) {
        
        if let latitude = data[LocationCoordinatesResponseParameters.Latitude.rawValue] {
            self.latitude = latitude.double
        }
        
        if let longitude = data[LocationCoordinatesResponseParameters.Longitude.rawValue] {
            self.longitude = longitude.double
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getLatitude() -> Double {
        return self.latitude
    }
    
    internal func getLongitude() -> Double {
        return self.longitude
    }
}
