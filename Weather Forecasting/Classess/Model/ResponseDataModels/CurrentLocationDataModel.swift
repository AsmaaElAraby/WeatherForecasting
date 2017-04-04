//
//  CurrentLocationDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum CurrentLocationResponseParameters: String  {
    case    Id           =   "id"
    case    Name         =   "name"
    case    Coordinates  =   "coord"
    case    Country      =   "country"
    case    Population   =   "population"
}

class CurrentLocationDataModel: NSObject {
    
    private var locationId:             Int!
    private var locationName:           String!
    private var locationCoordinates:    LocationCoordinatesDataModel!
    private var locationCountry:        String!
    private var locationPopulation:     Int!
    
    
    /// create instance from CurrentLocationDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let locationId = data[CurrentLocationResponseParameters.Id.rawValue] {
            self.locationId = locationId.int
        }
        
        if let locationName = data[CurrentLocationResponseParameters.Name.rawValue] {
            self.locationName = locationName.string
        }
        
        if let locationCoordinates = data[CurrentLocationResponseParameters.Coordinates.rawValue] {
            if let locationCoordinates = locationCoordinates.dictionary {

                self.locationCoordinates = LocationCoordinatesDataModel(data: locationCoordinates)
            }
        }
        
        if let locationCountry = data[CurrentLocationResponseParameters.Country.rawValue] {
            self.locationCountry = locationCountry.string
        }

        if let locationPopulation = data[CurrentLocationResponseParameters.Population.rawValue] {
            self.locationPopulation = locationPopulation.int
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getLocationId() -> Int {
        return self.locationId
    }
    
    internal func getLocationName() -> String {
        return self.locationName
    }
    
    internal func getLocationCoordinates() -> LocationCoordinatesDataModel {
        return self.locationCoordinates
    }
    
    internal func getLocationCountry() -> String {
        return self.locationCountry
    }
    
    internal func getLocationPopulation() -> Int {
        return self.locationPopulation
    }
}
