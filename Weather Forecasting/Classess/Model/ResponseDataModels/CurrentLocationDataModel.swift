//
//  CurrentLocationDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

struct CurrentLocationDataModel: Codable {
    
    let id:             Int
    let name:           String
    let coordinates:    LocationCoordinatesDataModel
    let country:        String
    let population:     Int
    
    
    enum CodingKeys: String, CodingKey {
        case    id           =   "id"
        case    name         =   "name"
        case    coordinates  =   "coord"
        case    country      =   "country"
        case    population   =   "population"
    }
    
}
