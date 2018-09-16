//
//  LocationCoordinatesDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct LocationCoordinatesDataModel: Codable {
    
    let latitude:   Double
    let longitude:  Double
    
    enum CodingKeys: String, CodingKey {
        
        case    latitude    =   "lat"
        case    longitude   =   "lon"
    }
    
    static func == (lhs: LocationCoordinatesDataModel, rhs: LocationCoordinatesDataModel) -> Bool {
        return (lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude)
    }
    
}
