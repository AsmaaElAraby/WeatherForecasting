//
//  CloudsDetailsDataModel.swift
//  Weather Forecasting
//
//  Created by mac on 4/4/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit
import SwiftyJSON

enum CloudsDetailsResponseParameters: String  {
    case    All   =   "all"
}

class CloudsDetailsDataModel: NSObject {
    
    private var all:  Int!
    
    /// create instance from CloudsDetailsDataModel with the dictionary received from server
    ///
    /// - Parameter data: [String : JSON]
    init(data: [String : JSON]) {
        
        if let all = data[CloudsDetailsResponseParameters.All.rawValue] {
            self.all = Int(all.double!)
        }
        
    }
    
    
    /// get methods to the model parameters
    
    internal func getAll() -> Int {
        return self.all
    }
    
}

