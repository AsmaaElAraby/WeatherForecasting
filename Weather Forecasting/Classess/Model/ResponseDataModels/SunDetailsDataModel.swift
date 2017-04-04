//
//  SunDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum SunDetailsResponseParameters: String  {
    case    ElementType =   "type"
    case    Id          =   "id"
    case    Message     =   "message"
    case    Country     =   "country"
    case    Sunrise     =   "sunrise"
    case    Sunset      =   "sunset"
}

class SunDetailsDataModel: NSObject {
    
    private var elementType:    Double!
    private var elementId:      Double!
    private var message:        Double!
    private var country:        String!
    private var sunrise:        Double!
    private var sunset:         Double!
    
    
    /// create instance from SunDetailsDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let elementType = data[SunDetailsResponseParameters.ElementType.rawValue] {
            self.elementType = elementType.double
        }
        
        if let elementId = data[SunDetailsResponseParameters.Id.rawValue] {
            self.elementId = elementId.double
        }
        
        if let message = data[SunDetailsResponseParameters.Message.rawValue] {
            self.message = message.double
        }
        
        if let country = data[SunDetailsResponseParameters.Country.rawValue] {
            self.country = country.string
        }
        
        if let sunrise = data[SunDetailsResponseParameters.Sunrise.rawValue] {
            self.sunrise = sunrise.double
        }
        
        if let sunset = data[SunDetailsResponseParameters.Sunset.rawValue] {
            self.sunset = sunset.double
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getElementType() -> Double {
        return self.elementType
    }
    
    internal func getElementId() -> Double {
        return self.elementId
    }
    
    internal func getMessage() -> Double {
        return self.message
    }
    
    internal func getCountry() -> String {
        return self.country
    }
    
    internal func getSunrise() -> Double {
        return self.sunrise
    }
    
    internal func getSunset() -> Double {
        return self.sunset
    }
}

