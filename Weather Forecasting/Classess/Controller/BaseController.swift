//
//  BaseController.swift
//  Weather Forecasting
//
//  Created by mac on 4/3/17.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

class BaseController {
    
    weak var delegate: RequestDelegate?
    
    /// set the controller delegate
    ///
    /// - Parameter delegate:   TodayWeatherDelegate
    internal func setDelegate(delegate: RequestDelegate) {
        self.delegate = delegate
    }
    
}
