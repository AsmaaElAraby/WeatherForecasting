//
//  TodayWindDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum WindDetailsResponseParameters: String  {
    case    Speed   =   "speed"
    case    Degree  =   "deg"
}

class WindDetailsDataModel: NSObject {
    
    private var speed:  Double!
    private var degree: Double!
    
    
    /// create instance from WindDetailsDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let speed = data[WindDetailsResponseParameters.Speed.rawValue] {
            self.speed = speed.double
        }
        
        if let degree = data[WindDetailsResponseParameters.Degree.rawValue] {
            self.degree = degree.double
        }
       
    }
    
    
    /// get methods to the model parameters
    
    internal func getSpeed() -> Double {
        return self.speed
    }
    
    internal func getDegree() -> Double {
        return self.degree
    }
    
}

