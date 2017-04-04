//
//  WeatherDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/2/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum WeatherStateResponseParameters: String  {
    case    Id           =   "id"
    case    Main         =   "main"
    case    Description  =   "description"
    case    Icon         =   "icon"
}

class WeatherStateDataModel: NSObject {
    
    private var elementId:          Int!
    private var elementMain:        String!
    private var elementDescription: String!
    private var elementIcon:        String!
    
    
    /// create instance from WeatherStateDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let elementId = data[WeatherStateResponseParameters.Id.rawValue] {
            self.elementId = elementId.int
        }
        
        if let elementMain = data[WeatherStateResponseParameters.Main.rawValue] {
            self.elementMain = elementMain.string
        }
        
        if let elementDescription = data[WeatherStateResponseParameters.Description.rawValue] {
            self.elementDescription = elementDescription.string
        }
        
        if let elementIcon = data[WeatherStateResponseParameters.Icon.rawValue] {
            self.elementIcon = elementIcon.string
        }
    }
    
    
    /// get methods to the model parameters
    
    internal func getElementId() -> Int {
        return self.elementId
    }
    
    internal func getElementMain() -> String {
        return self.elementMain
    }
    
    internal func getElementDescription() -> String {
        return self.elementDescription
    }
    
    internal func getElementIcon() -> String {
        return self.elementIcon
    }
}
